require 'pathname'

Puppet::Type.newtype(:dsc_xadcscertificationauthority) do
  require Pathname.new(__FILE__).dirname + '../../' + 'puppet/type/base_dsc'

  provide :powershell, :parent => Puppet::Type.type(:base_dsc).provider(:powershell) do
    defaultfor :operatingsystem => :windows
  end

  @doc = %q{
    The DSC xAdcsCertificationAuthority resource type.
    Originally generated from the following schema.mof file:
      import/dsc_resources/xAdcsDeployment/xCertificateServices/DSCResources/MSFT_xAdcsCertificationAuthority/MSFT_xAdcsCertificationAuthority.schema.mof
  }

  validate do
      fail('dsc_catype is a required attribute') if self[:dsc_catype].nil?
    end

  newparam(:dscmeta_resource_friendly_name) do
    defaultto "xAdcsCertificationAuthority"
  end

  newparam(:dscmeta_resource_name) do
    defaultto "MSFT_xAdcsCertificationAuthority"
  end

  newparam(:dscmeta_import_resource) do
    newvalues(true, false)

    munge do |value|
      provider.munge_boolean(value.to_s)
    end

    defaultto true
  end

  newparam(:dscmeta_module_name) do
    defaultto "xCertificateServices"
  end

  newparam(:dscmeta_module_version) do
    defaultto "0.1.0.0"
  end

  newparam(:name, :namevar => true ) do
  end

  ensurable do
    newvalue(:exists?) { provider.exists? }
    newvalue(:present) { provider.create }
    newvalue(:absent)  { provider.destroy }
    defaultto { :present }
  end

  # Name:         CAType
  # Type:         string
  # IsMandatory:  True
  # Values:       ["EnterpriseRootCA", "EnterpriseSubordinateCA", "StandaloneRootCA", "StandaloneSubordinateCA"]
  newparam(:dsc_catype) do
    desc "Specifies the type of certification authority to install. The possible values are EnterpriseRootCA, EnterpriseSubordinateCA, StandaloneRootCA, or StandaloneSubordinateCA."
    isrequired
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
      unless ['EnterpriseRootCA', 'enterpriserootca', 'EnterpriseSubordinateCA', 'enterprisesubordinateca', 'StandaloneRootCA', 'standalonerootca', 'StandaloneSubordinateCA', 'standalonesubordinateca'].include?(value)
        fail("Invalid value '#{value}'. Valid values are EnterpriseRootCA, EnterpriseSubordinateCA, StandaloneRootCA, StandaloneSubordinateCA")
      end
    end
  end

  # Name:         Credential
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_credential) do
    desc "To install an enterprise certification authority, the computer must be joined to an Active Directory Domain Services domain and a user account that is a member of the Enterprise Admin group is required. To install a standalone certification authority, the computer can be in a workgroup or AD DS domain. If the computer is in a workgroup, a user account that is a member of Administrators is required. If the computer is in an AD DS domain, a user account that is a member of Domain Admins is required."
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
    desc "Specifies whether the Certificate Authority should be installed or uninstalled."
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

  # Name:         CACommonName
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_cacommonname) do
    desc "Specifies the certification authority common name."
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         CADistinguishedNameSuffix
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_cadistinguishednamesuffix) do
    desc "Specifies the certification authority distinguished name suffix."
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         CertFile
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_certfile) do
    desc "Specifies the file name of certification authority PKCS 12 formatted certificate file."
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         CertFilePassword
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_certfilepassword) do
    desc "Specifies the password for certification authority certificate file."
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         CertificateID
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_certificateid) do
    desc "Specifies the thumbprint or serial number of certification authority certificate."
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         CryptoProviderName
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_cryptoprovidername) do
    desc "The name of the cryptographic service provider  or key storage provider that is used to generate or store the private key for the CA."
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         DatabaseDirectory
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_databasedirectory) do
    desc "Specifies the folder location of the certification authority database."
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         HashAlgorithmName
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_hashalgorithmname) do
    desc "Specifies the signature hash algorithm used by the certification authority."
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         IgnoreUnicode
  # Type:         boolean
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_ignoreunicode) do
    desc "Specifies that Unicode characters are allowed in certification authority name string."
    validate do |value|
    end
    newvalues(true, false)
    munge do |value|
      provider.munge_boolean(value.to_s)
    end
  end

  # Name:         KeyContainerName
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_keycontainername) do
    desc "Specifies the name of an existing private key container."
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         KeyLength
  # Type:         uint32
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_keylength) do
    desc "Specifies the name of an existing private key container."
    validate do |value|
      unless (value.kind_of?(Numeric) && value >= 0) || (value.to_i.to_s == value && value.to_i >= 0)
          fail("Invalid value #{value}. Should be a unsigned Integer")
      end
    end
    munge do |value|
      value.to_i
    end
  end

  # Name:         LogDirectory
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_logdirectory) do
    desc "Specifies the folder location of the certification authority database log."
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         OutputCertRequestFile
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_outputcertrequestfile) do
    desc "Specifies the folder location for certificate request file."
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         OverwriteExistingCAinDS
  # Type:         boolean
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_overwriteexistingcainds) do
    desc "Specifies that the computer object in the Active Directory Domain Service domain should be overwritten with the same computer name."
    validate do |value|
    end
    newvalues(true, false)
    munge do |value|
      provider.munge_boolean(value.to_s)
    end
  end

  # Name:         OverwriteExistingDatabase
  # Type:         boolean
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_overwriteexistingdatabase) do
    desc "Specifies that the existing certification authority database should be overwritten."
    validate do |value|
    end
    newvalues(true, false)
    munge do |value|
      provider.munge_boolean(value.to_s)
    end
  end

  # Name:         OverwriteExistingKey
  # Type:         boolean
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_overwriteexistingkey) do
    desc "Overwrite existing key container with the same name"
    validate do |value|
    end
    newvalues(true, false)
    munge do |value|
      provider.munge_boolean(value.to_s)
    end
  end

  # Name:         ParentCA
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_parentca) do
    desc "Specifies the configuration string of the parent certification authority that will certify this CA."
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         ValidityPeriod
  # Type:         string
  # IsMandatory:  False
  # Values:       ["Hours", "Days", "Months", "Years"]
  newparam(:dsc_validityperiod) do
    desc "Specifies the validity period of the certification authority certificate in hours, days, weeks, months or years. If this is a subordinate CA, do not use this parameter, because the validity period is determined by the parent CA."
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
      unless ['Hours', 'hours', 'Days', 'days', 'Months', 'months', 'Years', 'years'].include?(value)
        fail("Invalid value '#{value}'. Valid values are Hours, Days, Months, Years")
      end
    end
  end

  # Name:         ValidityPeriodUnits
  # Type:         uint32
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_validityperiodunits) do
    desc "Validity period of the certification authority certificate. If this is a subordinate CA, do not specify this parameter because the validity period is determined by the parent CA."
    validate do |value|
      unless (value.kind_of?(Numeric) && value >= 0) || (value.to_i.to_s == value && value.to_i >= 0)
          fail("Invalid value #{value}. Should be a unsigned Integer")
      end
    end
    munge do |value|
      value.to_i
    end
  end


end
