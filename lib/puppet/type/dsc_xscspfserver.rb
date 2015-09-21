require 'pathname'

Puppet::Type.newtype(:dsc_xscspfserver) do
  require Pathname.new(__FILE__).dirname + '../../' + 'puppet/type/base_dsc'

  provide :powershell, :parent => Puppet::Type.type(:base_dsc).provider(:powershell) do
    defaultfor :operatingsystem => :windows
  end

  @doc = %q{
    The DSC xSCSPFServer resource type.
    Originally generated from the following schema.mof file:
      import/dsc_resources/xSCSPF/DSCResources/MSFT_xSCSPFServer/MSFT_xSCSPFServer.schema.mof
  }

  validate do
      fail('dsc_name is a required attribute') if self[:dsc_name].nil?
    end

  newparam(:dscmeta_resource_friendly_name) do
    defaultto "xSCSPFServer"
  end

  newparam(:dscmeta_resource_name) do
    defaultto "MSFT_xSCSPFServer"
  end

  newparam(:dscmeta_import_resource) do
    newvalues(true, false)

    munge do |value|
      provider.munge_boolean(value.to_s)
    end

    defaultto true
  end

  newparam(:dscmeta_module_name) do
    defaultto "xSCSPF"
  end

  newparam(:dscmeta_module_version) do
    defaultto "1.3.1.0"
  end

  newparam(:name, :namevar => true ) do
  end

  ensurable do
    newvalue(:exists?) { provider.exists? }
    newvalue(:present) { provider.create }
    newvalue(:absent)  { provider.destroy }
    defaultto { :present }
  end

  # Name:         Ensure
  # Type:         string
  # IsMandatory:  False
  # Values:       ["Present", "Absent"]
  newparam(:dsc_ensure) do
    def mof_type; 'string' end
    def mof_is_embedded?; false end
    desc "An enumerated value that describes if the SPF server exists.\nPresent {default}  \nAbsent   \n"
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

  # Name:         Name
  # Type:         string
  # IsMandatory:  True
  # Values:       None
  newparam(:dsc_name) do
    def mof_type; 'string' end
    def mof_is_embedded?; false end
    desc "Specifies a name for the server."
    isrequired
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         ServerType
  # Type:         string
  # IsMandatory:  False
  # Values:       ["VMM", "OM", "DPM", "OMDW", "RDGateway", "Orchestrator", "None"]
  newparam(:dsc_servertype) do
    def mof_type; 'string' end
    def mof_is_embedded?; false end
    desc "Specifies the type of server."
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
      unless ['VMM', 'vmm', 'OM', 'om', 'DPM', 'dpm', 'OMDW', 'omdw', 'RDGateway', 'rdgateway', 'Orchestrator', 'orchestrator', 'None', 'none'].include?(value)
        fail("Invalid value '#{value}'. Valid values are VMM, OM, DPM, OMDW, RDGateway, Orchestrator, None")
      end
    end
  end

  # Name:         SCSPFAdminCredential
  # Type:         MSFT_Credential
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_scspfadmincredential) do
    def mof_type; 'MSFT_Credential' end
    def mof_is_embedded?; true end
    desc "Credential with admin permissions to Service Provider Foundation."
    validate do |value|
      unless value.kind_of?(Hash)
        fail("Invalid value '#{value}'. Should be a hash")
      end
    end
  end


end
