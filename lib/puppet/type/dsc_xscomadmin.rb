require 'pathname'

Puppet::Type.newtype(:dsc_xscomadmin) do
  require Pathname.new(__FILE__).dirname + '../../' + 'puppet/type/base_dsc'

  provide :powershell, :parent => Puppet::Type.type(:base_dsc).provider(:powershell) do
    defaultfor :operatingsystem => :windows
  end

  @doc = %q{
    The DSC xSCOMAdmin resource type.
    Originally generated from the following schema.mof file:
      import/dsc_resources/xSCOM/DSCResources/MSFT_xSCOMAdmin/MSFT_xSCOMAdmin.schema.mof
  }

  validate do
      fail('dsc_principal is a required attribute') if self[:dsc_principal].nil?
      fail('dsc_userrole is a required attribute') if self[:dsc_userrole].nil?
    end

  newparam(:dscmeta_resource_friendly_name) do
    defaultto "xSCOMAdmin"
  end

  newparam(:dscmeta_resource_name) do
    defaultto "MSFT_xSCOMAdmin"
  end

  newparam(:dscmeta_import_resource) do
    newvalues(true, false)

    munge do |value|
      provider.munge_boolean(value.to_s)
    end

    defaultto true
  end

  newparam(:dscmeta_module_name) do
    defaultto "xSCOM"
  end

  newparam(:dscmeta_module_version) do
    defaultto "1.3.3.0"
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
    desc "An enumerated value that describes if the principal is an Operations Manager admin.\nPresent {default}  \nAbsent   \n"
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

  # Name:         Principal
  # Type:         string
  # IsMandatory:  True
  # Values:       None
  newparam(:dsc_principal) do
    desc "The Operations Manager admin principal."
    isrequired
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         UserRole
  # Type:         string
  # IsMandatory:  True
  # Values:       None
  newparam(:dsc_userrole) do
    desc "The Operations Manager user role."
    isrequired
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         SCOMAdminCredential
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_scomadmincredential) do
    desc "Credential to be used to perform the operations."
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end


end
