require 'pathname'

Puppet::Type.newtype(:dsc_windowsprocess) do
  require Pathname.new(__FILE__).dirname + '../../' + 'puppet/type/base_dsc'

  provide :powershell, :parent => Puppet::Type.type(:base_dsc).provider(:powershell) do
    defaultfor :operatingsystem => :windows
  end

  @doc = %q{
    The DSC WindowsProcess resource type.
    Originally generated from the following schema.mof file:
      import/dsc_resources/PSDesiredStateConfiguration/DSCResources/MSFT_ProcessResource/MSFT_ProcessResource.schema.mof
  }

  validate do
      fail('dsc_path is a required attribute') if self[:dsc_path].nil?
      fail('dsc_arguments is a required attribute') if self[:dsc_arguments].nil?
    end

  newparam(:dscmeta_resource_friendly_name) do
    defaultto "WindowsProcess"
  end

  newparam(:dscmeta_resource_name) do
    defaultto "MSFT_ProcessResource"
  end

  newparam(:dscmeta_import_resource) do
    newvalues(true, false)

    munge do |value|
      provider.munge_boolean(value.to_s)
    end

    defaultto true
  end

  newparam(:dscmeta_module_name) do
    defaultto "PSDesiredStateConfiguration"
  end

  newparam(:name, :namevar => true ) do
  end

  ensurable do
    newvalue(:exists?) { provider.exists? }
    newvalue(:present) { provider.create }
    newvalue(:absent)  { provider.destroy }
    defaultto { :present }
  end

  # Name:         Path
  # Type:         string
  # IsMandatory:  True
  # Values:       None
  newparam(:dsc_path) do
    def mof_type; 'string' end
    def mof_is_embedded?; false end
    isrequired
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         Arguments
  # Type:         string
  # IsMandatory:  True
  # Values:       None
  newparam(:dsc_arguments) do
    def mof_type; 'string' end
    def mof_is_embedded?; false end
    isrequired
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         Credential
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_credential) do
    def mof_type; 'string' end
    def mof_is_embedded?; true end
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

  # Name:         StandardOutputPath
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_standardoutputpath) do
    def mof_type; 'string' end
    def mof_is_embedded?; false end
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         StandardErrorPath
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_standarderrorpath) do
    def mof_type; 'string' end
    def mof_is_embedded?; false end
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         StandardInputPath
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_standardinputpath) do
    def mof_type; 'string' end
    def mof_is_embedded?; false end
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         WorkingDirectory
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_workingdirectory) do
    def mof_type; 'string' end
    def mof_is_embedded?; false end
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         PagedMemorySize
  # Type:         uint64
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_pagedmemorysize) do
    def mof_type; 'uint64' end
    def mof_is_embedded?; false end
    validate do |value|
      unless (value.kind_of?(Numeric) && value >= 0) || (value.to_i.to_s == value && value.to_i >= 0)
          fail("Invalid value #{value}. Should be a unsigned Integer")
      end
    end
    munge do |value|
      value.to_i
    end
  end

  # Name:         NonPagedMemorySize
  # Type:         uint64
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_nonpagedmemorysize) do
    def mof_type; 'uint64' end
    def mof_is_embedded?; false end
    validate do |value|
      unless (value.kind_of?(Numeric) && value >= 0) || (value.to_i.to_s == value && value.to_i >= 0)
          fail("Invalid value #{value}. Should be a unsigned Integer")
      end
    end
    munge do |value|
      value.to_i
    end
  end

  # Name:         VirtualMemorySize
  # Type:         uint64
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_virtualmemorysize) do
    def mof_type; 'uint64' end
    def mof_is_embedded?; false end
    validate do |value|
      unless (value.kind_of?(Numeric) && value >= 0) || (value.to_i.to_s == value && value.to_i >= 0)
          fail("Invalid value #{value}. Should be a unsigned Integer")
      end
    end
    munge do |value|
      value.to_i
    end
  end

  # Name:         HandleCount
  # Type:         sint32
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_handlecount) do
    def mof_type; 'sint32' end
    def mof_is_embedded?; false end
    validate do |value|
      unless value.kind_of?(Numeric) || value.to_i.to_s == value || value.to_i >= 0
          fail("Invalid value #{value}. Should be a signed Integer")
      end
    end
    munge do |value|
      value.to_i
    end
  end

  # Name:         ProcessId
  # Type:         sint32
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_processid) do
    def mof_type; 'sint32' end
    def mof_is_embedded?; false end
    validate do |value|
      unless value.kind_of?(Numeric) || value.to_i.to_s == value || value.to_i >= 0
          fail("Invalid value #{value}. Should be a signed Integer")
      end
    end
    munge do |value|
      value.to_i
    end
  end


end
