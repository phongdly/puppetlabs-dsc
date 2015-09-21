require 'pathname'

Puppet::Type.newtype(:dsc_xpsendpoint) do
  require Pathname.new(__FILE__).dirname + '../../' + 'puppet/type/base_dsc'

  provide :powershell, :parent => Puppet::Type.type(:base_dsc).provider(:powershell) do
    defaultfor :operatingsystem => :windows
  end

  @doc = %q{
    The DSC xPSEndpoint resource type.
    Originally generated from the following schema.mof file:
      import/dsc_resources/xPSDesiredStateConfiguration/DSCResources/MSFT_xPSSessionConfiguration/MSFT_xPSSessionConfiguration.schema.mof
  }

  validate do
      fail('dsc_name is a required attribute') if self[:dsc_name].nil?
    end

  newparam(:dscmeta_resource_friendly_name) do
    defaultto "xPSEndpoint"
  end

  newparam(:dscmeta_resource_name) do
    defaultto "MSFT_xPSSessionConfiguration"
  end

  newparam(:dscmeta_import_resource) do
    newvalues(true, false)

    munge do |value|
      provider.munge_boolean(value.to_s)
    end

    defaultto true
  end

  newparam(:dscmeta_module_name) do
    defaultto "xPSDesiredStateConfiguration"
  end

  newparam(:dscmeta_module_version) do
    defaultto "3.4.0.0"
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
    desc "Name of the PS Remoting Endpoint"
    isrequired
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
    desc "Whether to create the endpoint or delete it"
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

  # Name:         StartupScript
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_startupscript) do
    def mof_type; 'string' end
    def mof_is_embedded?; false end
    desc "Path for the startup script"
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         RunAsCredential
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_runascredential) do
    def mof_type; 'string' end
    def mof_is_embedded?; true end
    desc "Credential for Running under different user context"
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         SecurityDescriptorSDDL
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_securitydescriptorsddl) do
    def mof_type; 'string' end
    def mof_is_embedded?; false end
    desc "SDDL for allowed users to connect to this endpoint"
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         AccessMode
  # Type:         string
  # IsMandatory:  False
  # Values:       ["Local", "Remote", "Disabled"]
  newparam(:dsc_accessmode) do
    def mof_type; 'string' end
    def mof_is_embedded?; false end
    desc "Whether the endpoint is remotely accessible or has local access only or no access"
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
      unless ['Local', 'local', 'Remote', 'remote', 'Disabled', 'disabled'].include?(value)
        fail("Invalid value '#{value}'. Valid values are Local, Remote, Disabled")
      end
    end
  end


end
