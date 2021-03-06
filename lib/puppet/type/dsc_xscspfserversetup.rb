require 'pathname'

Puppet::Type.newtype(:dsc_xscspfserversetup) do
  require Pathname.new(__FILE__).dirname + '../../' + 'puppet/type/base_dsc'

  provide :powershell, :parent => Puppet::Type.type(:base_dsc).provider(:powershell) do
    defaultfor :operatingsystem => :windows
  end

  @doc = %q{
    The DSC xSCSPFServerSetup resource type.
    Originally generated from the following schema.mof file:
      import/dsc_resources/xSCSPF/DSCResources/MSFT_xSCSPFServerSetup/MSFT_xSCSPFServerSetup.schema.mof
  }

  validate do
      fail('dsc_ensure is a required attribute') if self[:dsc_ensure].nil?
    end

  newparam(:dscmeta_resource_friendly_name) do
    defaultto "xSCSPFServerSetup"
  end

  newparam(:dscmeta_resource_name) do
    defaultto "MSFT_xSCSPFServerSetup"
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
  # IsMandatory:  True
  # Values:       ["Present", "Absent"]
  newparam(:dsc_ensure) do
    desc "An enumerated value that describes if SPF server is expected to be installed on the machine.\nPresent {default}  \nAbsent   \n"
    isrequired
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

  # Name:         SourcePath
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_sourcepath) do
    desc "UNC path to the root of the source files for installation."
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         SourceFolder
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_sourcefolder) do
    desc "Folder within the source path containing the source files for installation."
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         SetupCredential
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_setupcredential) do
    desc "Credential to be used to perform the installation."
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         SendCEIPReports
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_sendceipreports) do
    desc "Participate in the Customer Experience Improvement Program."
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         UseMicrosoftUpdate
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_usemicrosoftupdate) do
    desc "Use Microsoft Update."
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         SpecifyCertificate
  # Type:         boolean
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_specifycertificate) do
    desc "Use an existing certificate."
    validate do |value|
    end
    newvalues(true, false)
    munge do |value|
      provider.munge_boolean(value.to_s)
    end
  end

  # Name:         CertificateName
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_certificatename) do
    desc "Name of existing certificate to use."
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         DatabaseServer
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_databaseserver) do
    desc "Name of the database server."
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         DatabasePortNumber
  # Type:         uint16
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_databaseportnumber) do
    desc "Port of the database server instance."
    validate do |value|
      unless (value.kind_of?(Numeric) && value >= 0) || (value.to_i.to_s == value && value.to_i >= 0)
          fail("Invalid value #{value}. Should be a unsigned Integer")
      end
    end
    munge do |value|
      value.to_i
    end
  end

  # Name:         DatabaseName
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_databasename) do
    desc "Name of the SPF database."
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         WebSitePortNumber
  # Type:         uint16
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_websiteportnumber) do
    desc "Port for the SPF web service."
    validate do |value|
      unless (value.kind_of?(Numeric) && value >= 0) || (value.to_i.to_s == value && value.to_i >= 0)
          fail("Invalid value #{value}. Should be a unsigned Integer")
      end
    end
    munge do |value|
      value.to_i
    end
  end

  # Name:         SCVMM
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_scvmm) do
    desc "Credential for the VMM application pool."
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         SCVMMUsername
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_scvmmusername) do
    desc "Output username of the VMM application pool serivce."
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         SCAdmin
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_scadmin) do
    desc "Credential for the Admin application pool"
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         SCAdminUsername
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_scadminusername) do
    desc "Output username of the Admin application pool serivce."
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         SCProvider
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_scprovider) do
    desc "Credential for the Provider application pool"
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         SCProviderUsername
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_scproviderusername) do
    desc "Output username of the Provider application pool serivce."
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         SCUsage
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_scusage) do
    desc "Credential for the Usage application pool"
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         SCUsageUsername
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_scusageusername) do
    desc "Output username of the Usage application pool serivce."
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         VMMSecurityGroupUsers
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_vmmsecuritygroupusers) do
    desc "Administrator of the VMM application pool."
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         AdminSecurityGroupUsers
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_adminsecuritygroupusers) do
    desc "Administrator of the Admin application pool"
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         ProviderSecurityGroupUsers
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_providersecuritygroupusers) do
    desc "Administrator of the Provider application pool"
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         UsageSecurityGroupUsers
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_usagesecuritygroupusers) do
    desc "Administrator of the Usage application pool"
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end


end
