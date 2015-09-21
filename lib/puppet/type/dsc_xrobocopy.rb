require 'pathname'

Puppet::Type.newtype(:dsc_xrobocopy) do
  require Pathname.new(__FILE__).dirname + '../../' + 'puppet/type/base_dsc'

  provide :powershell, :parent => Puppet::Type.type(:base_dsc).provider(:powershell) do
    defaultfor :operatingsystem => :windows
  end

  @doc = %q{
    The DSC xRobocopy resource type.
    Originally generated from the following schema.mof file:
      import/dsc_resources/xRobocopy/DSCResources/MSFT_xRobocopy/MSFT_xRobocopy.schema.mof
  }

  validate do
      fail('dsc_source is a required attribute') if self[:dsc_source].nil?
      fail('dsc_destination is a required attribute') if self[:dsc_destination].nil?
    end

  newparam(:dscmeta_resource_friendly_name) do
    defaultto "xRobocopy"
  end

  newparam(:dscmeta_resource_name) do
    defaultto "MSFT_xRobocopy"
  end

  newparam(:dscmeta_import_resource) do
    newvalues(true, false)

    munge do |value|
      provider.munge_boolean(value.to_s)
    end

    defaultto true
  end

  newparam(:dscmeta_module_name) do
    defaultto "xRobocopy"
  end

  newparam(:dscmeta_module_version) do
    defaultto "1.1.0.0"
  end

  newparam(:name, :namevar => true ) do
  end

  ensurable do
    newvalue(:exists?) { provider.exists? }
    newvalue(:present) { provider.create }
    defaultto { :present }
  end

  # Name:         Source
  # Type:         string
  # IsMandatory:  True
  # Values:       None
  newparam(:dsc_source) do
    def mof_type; 'string' end
    def mof_is_embedded?; false end
    desc "Source Directory, Drive or UNC path."
    isrequired
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         Destination
  # Type:         string
  # IsMandatory:  True
  # Values:       None
  newparam(:dsc_destination) do
    def mof_type; 'string' end
    def mof_is_embedded?; false end
    desc "Destination Dir, Drive or UNC path."
    isrequired
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         Files
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_files) do
    def mof_type; 'string' end
    def mof_is_embedded?; false end
    desc "File(s) to copy  (names/wildcards: default is all files)."
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         Retry
  # Type:         uint32
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_retry) do
    def mof_type; 'uint32' end
    def mof_is_embedded?; false end
    desc "Number of Retries on failed copies: default 1 million."
    validate do |value|
      unless (value.kind_of?(Numeric) && value >= 0) || (value.to_i.to_s == value && value.to_i >= 0)
          fail("Invalid value #{value}. Should be a unsigned Integer")
      end
    end
    munge do |value|
      value.to_i
    end
  end

  # Name:         Wait
  # Type:         uint32
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_wait) do
    def mof_type; 'uint32' end
    def mof_is_embedded?; false end
    desc "Wait time between retries: default is 30 seconds."
    validate do |value|
      unless (value.kind_of?(Numeric) && value >= 0) || (value.to_i.to_s == value && value.to_i >= 0)
          fail("Invalid value #{value}. Should be a unsigned Integer")
      end
    end
    munge do |value|
      value.to_i
    end
  end

  # Name:         SubdirectoriesIncludingEmpty
  # Type:         boolean
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_subdirectoriesincludingempty) do
    def mof_type; 'boolean' end
    def mof_is_embedded?; false end
    desc "Copy subdirectories, including Empty ones."
    validate do |value|
    end
    newvalues(true, false)
    munge do |value|
      provider.munge_boolean(value.to_s)
    end
  end

  # Name:         Restartable
  # Type:         boolean
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_restartable) do
    def mof_type; 'boolean' end
    def mof_is_embedded?; false end
    desc "Copy files in restartable mode."
    validate do |value|
    end
    newvalues(true, false)
    munge do |value|
      provider.munge_boolean(value.to_s)
    end
  end

  # Name:         MultiThreaded
  # Type:         boolean
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_multithreaded) do
    def mof_type; 'boolean' end
    def mof_is_embedded?; false end
    desc "Do multi-threaded copies with n threads (default 8). N must be at least 1 and not greater than 128. This option is incompatible with the /IPG and /EFSRAW options. Redirect output using /LOG option for better performance."
    validate do |value|
    end
    newvalues(true, false)
    munge do |value|
      provider.munge_boolean(value.to_s)
    end
  end

  # Name:         ExcludeFiles
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_excludefiles) do
    def mof_type; 'string' end
    def mof_is_embedded?; false end
    desc "Exclude Files matching given names/paths/wildcards."
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         LogOutput
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_logoutput) do
    def mof_type; 'string' end
    def mof_is_embedded?; false end
    desc "Output status to LOG file."
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         AppendLog
  # Type:         boolean
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_appendlog) do
    def mof_type; 'boolean' end
    def mof_is_embedded?; false end
    desc "Determine whether to overwrite log file or append."
    validate do |value|
    end
    newvalues(true, false)
    munge do |value|
      provider.munge_boolean(value.to_s)
    end
  end

  # Name:         AdditionalArgs
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_additionalargs) do
    def mof_type; 'string' end
    def mof_is_embedded?; false end
    desc "Robocopy has MANY configuration options.  Too many to present them all as DSC parameters effectively. Use this option to set additional parameters.  The string will be appended to the arguements list.  For a list of options run Robocopy /??? in a shell window."
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end


end
