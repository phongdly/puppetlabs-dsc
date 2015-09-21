require 'pathname'

Puppet::Type.newtype(:dsc_xexchjetstresscleanup) do
  require Pathname.new(__FILE__).dirname + '../../' + 'puppet/type/base_dsc'

  provide :powershell, :parent => Puppet::Type.type(:base_dsc).provider(:powershell) do
    defaultfor :operatingsystem => :windows
  end

  @doc = %q{
    The DSC xExchJetstressCleanup resource type.
    Originally generated from the following schema.mof file:
      import/dsc_resources/xExchange/DSCResources/MSFT_xExchJetstressCleanup/MSFT_xExchJetstressCleanup.schema.mof
  }

  validate do
      fail('dsc_jetstresspath is a required attribute') if self[:dsc_jetstresspath].nil?
    end

  newparam(:dscmeta_resource_friendly_name) do
    defaultto "xExchJetstressCleanup"
  end

  newparam(:dscmeta_resource_name) do
    defaultto "MSFT_xExchJetstressCleanup"
  end

  newparam(:dscmeta_import_resource) do
    newvalues(true, false)

    munge do |value|
      provider.munge_boolean(value.to_s)
    end

    defaultto true
  end

  newparam(:dscmeta_module_name) do
    defaultto "xExchange"
  end

  newparam(:dscmeta_module_version) do
    defaultto "1.2.0.0"
  end

  newparam(:name, :namevar => true ) do
  end

  ensurable do
    newvalue(:exists?) { provider.exists? }
    newvalue(:present) { provider.create }
    defaultto { :present }
  end

  # Name:         JetstressPath
  # Type:         string
  # IsMandatory:  True
  # Values:       None
  newparam(:dsc_jetstresspath) do
    def mof_type; 'string' end
    def mof_is_embedded?; false end
    desc "The path to the folder where Jetstress is installed, and which contains JetstressCmd.exe"
    isrequired
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         ConfigFilePath
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_configfilepath) do
    def mof_type; 'string' end
    def mof_is_embedded?; false end
    desc "Either ConfigFilePath, or DatabasePaths AND LogPaths MUST be specified. ConfigFilePath takes precedence. This is the full path to the JetstressConfig.xml file. If ConfigFilePath is specified, the config file will be used to determine the database and log folders that need to be removed"
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         DatabasePaths
  # Type:         string[]
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_databasepaths, :array_matching => :all) do
    def mof_type; 'string[]' end
    def mof_is_embedded?; false end
    desc "Either ConfigFilePath, or DatabasePaths AND LogPaths MUST be specified. DatabasePaths specifies the paths to database directories that should be cleaned up."
    validate do |value|
      unless value.kind_of?(Array) || value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string or an array of strings")
      end
    end
    munge do |value|
      Array(value)
    end
  end

  # Name:         DeleteAssociatedMountPoints
  # Type:         boolean
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_deleteassociatedmountpoints) do
    def mof_type; 'boolean' end
    def mof_is_embedded?; false end
    desc "Defaults to $false. If specified, indicates that mount points associated with the Jetstress database and log paths should be removed"
    validate do |value|
    end
    newvalues(true, false)
    munge do |value|
      provider.munge_boolean(value.to_s)
    end
  end

  # Name:         LogPaths
  # Type:         string[]
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_logpaths, :array_matching => :all) do
    def mof_type; 'string[]' end
    def mof_is_embedded?; false end
    desc "Either ConfigFilePath, or DatabasePaths AND LogPaths MUST be specified. LogPaths specifies the paths to log directories that should be cleaned up."
    validate do |value|
      unless value.kind_of?(Array) || value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string or an array of strings")
      end
    end
    munge do |value|
      Array(value)
    end
  end

  # Name:         OutputSaveLocation
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_outputsavelocation) do
    def mof_type; 'string' end
    def mof_is_embedded?; false end
    desc "If RemoveBinaries is set to $true and Jetstress output was saved to the default location (the installation path of Jetstress), specifies the folder path to copy the Jetstress output files to."
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         RemoveBinaries
  # Type:         boolean
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_removebinaries) do
    def mof_type; 'boolean' end
    def mof_is_embedded?; false end
    desc "Specifies that the files in the Jetstress installation directory should be removed"
    validate do |value|
    end
    newvalues(true, false)
    munge do |value|
      provider.munge_boolean(value.to_s)
    end
  end


end
