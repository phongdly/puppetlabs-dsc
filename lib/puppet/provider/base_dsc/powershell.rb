require 'pathname'
require Pathname.new(__FILE__).dirname + '../../../' + 'puppet/feature/vendors_dsc'
require 'json'

Puppet::Type.type(:base_dsc).provide(:powershell) do
  confine :operatingsystem => :windows
  defaultfor :operatingsystem => :windows
  has_features :vendors_dsc

  commands :powershell =>
    if File.exists?("#{ENV['SYSTEMROOT']}\\sysnative\\WindowsPowershell\\v1.0\\powershell.exe")
      "#{ENV['SYSTEMROOT']}\\sysnative\\WindowsPowershell\\v1.0\\powershell.exe"
    elsif File.exists?("#{ENV['SYSTEMROOT']}\\system32\\WindowsPowershell\\v1.0\\powershell.exe")
      "#{ENV['SYSTEMROOT']}\\system32\\WindowsPowershell\\v1.0\\powershell.exe"
    else
      'powershell.exe'
    end

  desc <<-EOT
Applies DSC Resources by generating a configuration file and applying it.
EOT

  def dsc_parameters
    resource.parameters_with_value.select do |p|
      p.name.to_s =~ /dsc_/
    end
  end

  def template_path
    File.expand_path('../../templates', __FILE__)
  end


  def powershell_args
    ['-NoProfile', '-NonInteractive', '-NoLogo', '-ExecutionPolicy', 'Bypass', '-Command']
  end

  def exists?
    script_content = ps_script_content('test')
    Puppet.debug "\n" + script_content
    output = powershell(powershell_args, script_content)
    Puppet.debug "Dsc Resource returned: #{output}"
    data = JSON.parse(output)
    fail(data['errormessage']) if !data['errormessage'].empty?
    exists = data['indesiredstate']
    Puppet.debug "Dsc Resource Exists?: #{exists}"
    Puppet.debug "dsc_ensure: #{resource[:dsc_ensure]}" if resource.parameters.has_key?(:dsc_ensure)
    Puppet.debug "ensure: #{resource[:ensure]}"
    exists
  end

  def create
    script_content = ps_script_content('set')
    Puppet.debug "\n" + script_content
    output = powershell(powershell_args, script_content)
    Puppet.debug "Create Dsc Resource returned: #{output}"
    data = JSON.parse(output)
    fail(data['errormessage']) if !data['errormessage'].empty?
    true
  end

  def destroy
    script_content = ps_script_content('set')
    Puppet.debug "\n" + script_content
    output = powershell(powershell_args, script_content)
    Puppet.debug "Destroy Dsc Resource returned: #{output}"
    data = JSON.parse(output)
    fail(data['errormessage']) if !data['errormessage'].empty?
    true
  end

  def munge_boolean(value)
    return true if value =~ (/^(true|t|yes|y|1)$/i)
    return false if value.empty? || value =~ (/^(false|f|no|n|0)$/i)

    raise ArgumentError.new "invalid value: #{value}"
  end

  def munge_embeddedinstance(mof_type, embeddedinstance_value)
    remapped_value = embeddedinstance_value.map do |key, value|
      if mof_type[key.downcase]
        case mof_type[key.downcase][:type]
        when "bool", "boolean"
          value = munge_boolean(value.to_s)
        # particularly important to Puppet 3.x which parses numbers as strings
        when "uint8","uint16","uint32","uint64",
          "uint8[]","uint16[]","uint32[]","uint64[]",
          "int16","int32","int64",
          "sint16","sint32","sint64",
          "int16[]","int32[]","int64[]"

          unless Array(value).all? { |v| v.is_a?(Numeric) || v =~ /^[-+]?\d+$/ }
            fail "#{key} should only include numeric values: invalid value #{value}"
          end

          value = value.is_a?(Array) ? value.map { |v| v.to_i } : value.to_i
        end
      end

      [key, value]
    end

    Hash[remapped_value]
  end

  def format_dsc_value(dsc_value)
    case
    when dsc_value.class.name == 'String'
      "'#{escape_quotes(dsc_value)}'"
    when dsc_value.class.ancestors.include?(Numeric)
      "#{dsc_value}"
    when [:true, :false].include?(dsc_value)
      "$#{dsc_value.to_s}"
    when ['trueclass','falseclass'].include?(dsc_value.class.name.downcase)
      "$#{dsc_value.to_s}"
    when dsc_value.class.name == 'Array'
      "@(" + dsc_value.collect{|m| format_dsc_value(m)}.join(', ') + ")"
    when dsc_value.class.name == 'Hash'
      "@{" + dsc_value.collect{|k, v| format_dsc_value(k) + ' = ' + format_dsc_value(v)}.join('; ') + "}"
    else
      fail "unsupported type #{dsc_value.class} of value '#{dsc_value}'"
    end
  end

  def validate_MSFT_Credential(name, value)
    unless value.kind_of?(Hash)
      fail("Invalid value '#{value}'. Should be a hash")
    end

    required = ['user', 'password']
    required.each do |key|
      if value[key]
        fail "#{key} for #{name} should be a String" unless value[key].is_a? String
      end
    end

    specified_keys = value.keys.map(&:to_s)

    missing = required - specified_keys
    unless missing.empty?
      fail "#{name} is missing the following required keys: #{missing.join(',')}"
    end

    extraneous = specified_keys - required
    unless extraneous.empty?
      fail "#{name} includes invalid keys: #{extraneous.join(',')}"
    end
  end

  def escape_quotes(text)
    text.gsub("'", "''")
  end

  def ps_script_content(mode)
    dsc_invoke_method = mode
    @param_hash = resource
    template = ERB.new(File.new(template_path + "/invoke_dsc_resource.ps1.erb").read, nil, '-')
    template.result(binding)
  end
end
