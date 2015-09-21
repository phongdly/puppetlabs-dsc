require 'pathname'

Puppet::Type.newtype(:dsc_xwebsite) do
  require Pathname.new(__FILE__).dirname + '../../' + 'puppet/type/base_dsc'

  provide :powershell, :parent => Puppet::Type.type(:base_dsc).provider(:powershell) do
    defaultfor :operatingsystem => :windows
  end

  @doc = %q{
    The DSC xWebsite resource type.
    Originally generated from the following schema.mof file:
      import/dsc_resources/xWebAdministration/DSCResources/MSFT_xWebsite/MSFT_xWebsite.schema.mof
  }

  validate do
      fail('dsc_name is a required attribute') if self[:dsc_name].nil?
    end

  newparam(:dscmeta_resource_friendly_name) do
    defaultto "xWebsite"
  end

  newparam(:dscmeta_resource_name) do
    defaultto "MSFT_xWebsite"
  end

  newparam(:dscmeta_import_resource) do
    newvalues(true, false)

    munge do |value|
      provider.munge_boolean(value.to_s)
    end

    defaultto true
  end

  newparam(:dscmeta_module_name) do
    defaultto "xWebAdministration"
  end

  newparam(:dscmeta_module_version) do
    defaultto "1.7.0.0"
  end

  newparam(:name, :namevar => true ) do
  end

  ensurable do
    newvalue(:exists?) { provider.exists? }
    newvalue(:present) { provider.create }
    newvalue(:absent)  { provider.destroy }
    defaultto { :present }
  end

  # Name:         Name
  # Type:         string
  # IsMandatory:  True
  # Values:       None
  newparam(:dsc_name) do
    def mof_type; 'string' end
    def mof_is_embedded?; false end
    isrequired
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         PhysicalPath
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_physicalpath) do
    def mof_type; 'string' end
    def mof_is_embedded?; false end
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         Ensure
  # Type:         string
  # IsMandatory:  False
  # Values:       ["Present", "Absent"]
  newparam(:dsc_ensure) do
    def mof_type; 'string' end
    def mof_is_embedded?; false end
    validate do |value|
      resource[:ensure] = value.downcase
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
      unless ['Present', 'present', 'Absent', 'absent'].include?(value)
        fail("Invalid value '#{value}'. Valid values are Present, Absent")
      end
    end
  end

  # Name:         State
  # Type:         string
  # IsMandatory:  False
  # Values:       ["Started", "Stopped"]
  newparam(:dsc_state) do
    def mof_type; 'string' end
    def mof_is_embedded?; false end
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
      unless ['Started', 'started', 'Stopped', 'stopped'].include?(value)
        fail("Invalid value '#{value}'. Valid values are Started, Stopped")
      end
    end
  end

  # Name:         BindingInfo
  # Type:         MSFT_xWebBindingInformation[]
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_bindinginfo, :array_matching => :all) do
    def mof_type; 'MSFT_xWebBindingInformation[]' end
    def mof_is_embedded?; true end
    def mof_type_map
      {"port"=>{:type=>"uint16"}, "protocol"=>{:type=>"string", :values=>["http", "https"]}, "ipaddress"=>{:type=>"string"}, "hostname"=>{:type=>"string"}, "certificatethumbprint"=>{:type=>"string"}, "certificatestorename"=>{:type=>"string", :values=>["My", "WebHosting"]}, "sslflags"=>{:type=>"string"}}
    end
    desc "Hashtable containing binding information (Port, Protocol, IPAddress, HostName, CertificateThumbPrint, CertificateStore)"
    validate do |value|
      unless value.kind_of?(Array) || value.kind_of?(Hash)
        fail("Invalid value '#{value}'. Should be an array of hashes or a hash")
      end
      (value.kind_of?(Hash) ? [value] : value).each_with_index do |v, i|
        fail "BindingInfo value at index #{i} should be a Hash" unless v.is_a? Hash
      end
    end
    munge do |value|
      value.kind_of?(Hash) ?
        [provider.munge_embeddedinstance(mof_type_map, value)] :
        value.map { |v| provider.munge_embeddedinstance(mof_type_map, v) }
    end
  end

  # Name:         ApplicationPool
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_applicationpool) do
    def mof_type; 'string' end
    def mof_is_embedded?; false end
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         Id
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_id) do
    def mof_type; 'string' end
    def mof_is_embedded?; false end
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         DefaultPage
  # Type:         string[]
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_defaultpage, :array_matching => :all) do
    def mof_type; 'string[]' end
    def mof_is_embedded?; false end
    desc "The default pages for the website"
    validate do |value|
      unless value.kind_of?(Array) || value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string or an array of strings")
      end
    end
    munge do |value|
      Array(value)
    end
  end


end
