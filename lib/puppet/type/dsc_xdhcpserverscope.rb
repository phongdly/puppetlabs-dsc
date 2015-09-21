require 'pathname'

Puppet::Type.newtype(:dsc_xdhcpserverscope) do
  require Pathname.new(__FILE__).dirname + '../../' + 'puppet/type/base_dsc'

  provide :powershell, :parent => Puppet::Type.type(:base_dsc).provider(:powershell) do
    defaultfor :operatingsystem => :windows
  end

  @doc = %q{
    The DSC xDhcpServerScope resource type.
    Originally generated from the following schema.mof file:
      import/dsc_resources/xDhcpServer/DSCResources/MSFT_xDhcpServerScope/MSFT_xDhcpServerScope.schema.mof
  }

  validate do
      fail('dsc_ipstartrange is a required attribute') if self[:dsc_ipstartrange].nil?
      fail('dsc_ipendrange is a required attribute') if self[:dsc_ipendrange].nil?
    end

  newparam(:dscmeta_resource_friendly_name) do
    defaultto "xDhcpServerScope"
  end

  newparam(:dscmeta_resource_name) do
    defaultto "MSFT_xDhcpServerScope"
  end

  newparam(:dscmeta_import_resource) do
    newvalues(true, false)

    munge do |value|
      provider.munge_boolean(value.to_s)
    end

    defaultto true
  end

  newparam(:dscmeta_module_name) do
    defaultto "xDhcpServer"
  end

  newparam(:dscmeta_module_version) do
    defaultto "1.2"
  end

  newparam(:name, :namevar => true ) do
  end

  ensurable do
    newvalue(:exists?) { provider.exists? }
    newvalue(:present) { provider.create }
    newvalue(:absent)  { provider.destroy }
    defaultto { :present }
  end

  # Name:         IPStartRange
  # Type:         string
  # IsMandatory:  True
  # Values:       None
  newparam(:dsc_ipstartrange) do
    def mof_type; 'string' end
    def mof_is_embedded?; false end
    desc "Starting address to set for this scope"
    isrequired
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         IPEndRange
  # Type:         string
  # IsMandatory:  True
  # Values:       None
  newparam(:dsc_ipendrange) do
    def mof_type; 'string' end
    def mof_is_embedded?; false end
    desc "Ending address to set for this scope"
    isrequired
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         Name
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_name) do
    def mof_type; 'string' end
    def mof_is_embedded?; false end
    desc "Name of DHCP Scope"
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         SubnetMask
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_subnetmask) do
    def mof_type; 'string' end
    def mof_is_embedded?; false end
    desc "Subnet mask for the scope specified in IP address format"
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         LeaseDuration
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_leaseduration) do
    def mof_type; 'string' end
    def mof_is_embedded?; false end
    desc "Time interval for which an IP address should be leased"
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         State
  # Type:         string
  # IsMandatory:  False
  # Values:       ["Active", "Inactive"]
  newparam(:dsc_state) do
    def mof_type; 'string' end
    def mof_is_embedded?; false end
    desc "Whether scope should be active or inactive"
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
      unless ['Active', 'active', 'Inactive', 'inactive'].include?(value)
        fail("Invalid value '#{value}'. Valid values are Active, Inactive")
      end
    end
  end

  # Name:         AddressFamily
  # Type:         string
  # IsMandatory:  False
  # Values:       ["IPv4"]
  newparam(:dsc_addressfamily) do
    def mof_type; 'string' end
    def mof_is_embedded?; false end
    desc "Address family type"
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
      unless ['IPv4', 'ipv4'].include?(value)
        fail("Invalid value '#{value}'. Valid values are IPv4")
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
    desc "Whether scope should be set or removed"
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

  # Name:         ScopeID
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_scopeid) do
    def mof_type; 'string' end
    def mof_is_embedded?; false end
    desc "ScopeId for the given scope"
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end


end
