require 'pathname'

Puppet::Type.newtype(:dsc_xmysqlserver) do
  require Pathname.new(__FILE__).dirname + '../../' + 'puppet/type/base_dsc'

  provide :powershell, :parent => Puppet::Type.type(:base_dsc).provider(:powershell) do
    defaultfor :operatingsystem => :windows
  end

  @doc = %q{
    The DSC xMySqlServer resource type.
    Originally generated from the following schema.mof file:
      import/dsc_resources/xMySql/DscResources/MSFT_xMySqlServer/MSFT_xMySqlServer.schema.mof
  }

  validate do
      fail('dsc_servicename is a required attribute') if self[:dsc_servicename].nil?
    end

  newparam(:dscmeta_resource_friendly_name) do
    defaultto "xMySqlServer"
  end

  newparam(:dscmeta_resource_name) do
    defaultto "MSFT_xMySqlServer"
  end

  newparam(:dscmeta_import_resource) do
    newvalues(true, false)

    munge do |value|
      provider.munge_boolean(value.to_s)
    end

    defaultto true
  end

  newparam(:dscmeta_module_name) do
    defaultto "xMySql"
  end

  newparam(:dscmeta_module_version) do
    defaultto "1.0.0.0"
  end

  newparam(:name, :namevar => true ) do
  end

  ensurable do
    newvalue(:exists?) { provider.exists? }
    newvalue(:present) { provider.create }
    newvalue(:absent)  { provider.destroy }
    defaultto { :present }
  end

  # Name:         ServiceName
  # Type:         string
  # IsMandatory:  True
  # Values:       None
  newparam(:dsc_servicename) do
    def mof_type; 'string' end
    def mof_is_embedded?; false end
    desc "Provides the service name to use during setup of MySQL"
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
    desc "Ensure resource is present or absent"
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

  # Name:         RootPassword
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_rootpassword) do
    def mof_type; 'string' end
    def mof_is_embedded?; true end
    desc "The root credential that is used to install mySql server."
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end


end
