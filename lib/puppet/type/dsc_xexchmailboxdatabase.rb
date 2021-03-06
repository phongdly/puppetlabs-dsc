require 'pathname'

Puppet::Type.newtype(:dsc_xexchmailboxdatabase) do
  require Pathname.new(__FILE__).dirname + '../../' + 'puppet/type/base_dsc'

  provide :powershell, :parent => Puppet::Type.type(:base_dsc).provider(:powershell) do
    defaultfor :operatingsystem => :windows
  end

  @doc = %q{
    The DSC xExchMailboxDatabase resource type.
    Originally generated from the following schema.mof file:
      import/dsc_resources/xExchange/DSCResources/MSFT_xExchMailboxDatabase/MSFT_xExchMailboxDatabase.schema.mof
  }

  validate do
      fail('dsc_name is a required attribute') if self[:dsc_name].nil?
    end

  newparam(:dscmeta_resource_friendly_name) do
    defaultto "xExchMailboxDatabase"
  end

  newparam(:dscmeta_resource_name) do
    defaultto "MSFT_xExchMailboxDatabase"
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

  # Name:         Name
  # Type:         string
  # IsMandatory:  True
  # Values:       None
  newparam(:dsc_name) do
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
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         DatabaseCopyCount
  # Type:         uint32
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_databasecopycount) do
    validate do |value|
      unless (value.kind_of?(Numeric) && value >= 0) || (value.to_i.to_s == value && value.to_i >= 0)
          fail("Invalid value #{value}. Should be a unsigned Integer")
      end
    end
    munge do |value|
      value.to_i
    end
  end

  # Name:         Server
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_server) do
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         EdbFilePath
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_edbfilepath) do
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         LogFolderPath
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_logfolderpath) do
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         AdServerSettingsPreferredServer
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_adserversettingspreferredserver) do
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         SkipInitialDatabaseMount
  # Type:         boolean
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_skipinitialdatabasemount) do
    validate do |value|
    end
    newvalues(true, false)
    munge do |value|
      provider.munge_boolean(value.to_s)
    end
  end

  # Name:         AllowServiceRestart
  # Type:         boolean
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_allowservicerestart) do
    validate do |value|
    end
    newvalues(true, false)
    munge do |value|
      provider.munge_boolean(value.to_s)
    end
  end

  # Name:         AutoDagExcludeFromMonitoring
  # Type:         boolean
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_autodagexcludefrommonitoring) do
    validate do |value|
    end
    newvalues(true, false)
    munge do |value|
      provider.munge_boolean(value.to_s)
    end
  end

  # Name:         BackgroundDatabaseMaintenance
  # Type:         boolean
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_backgrounddatabasemaintenance) do
    validate do |value|
    end
    newvalues(true, false)
    munge do |value|
      provider.munge_boolean(value.to_s)
    end
  end

  # Name:         CalendarLoggingQuota
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_calendarloggingquota) do
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         CircularLoggingEnabled
  # Type:         boolean
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_circularloggingenabled) do
    validate do |value|
    end
    newvalues(true, false)
    munge do |value|
      provider.munge_boolean(value.to_s)
    end
  end

  # Name:         DataMoveReplicationConstraint
  # Type:         string
  # IsMandatory:  False
  # Values:       ["None", "SecondCopy", "SecondDatacenter", "AllDatacenters", "AllCopies"]
  newparam(:dsc_datamovereplicationconstraint) do
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
      unless ['None', 'none', 'SecondCopy', 'secondcopy', 'SecondDatacenter', 'seconddatacenter', 'AllDatacenters', 'alldatacenters', 'AllCopies', 'allcopies'].include?(value)
        fail("Invalid value '#{value}'. Valid values are None, SecondCopy, SecondDatacenter, AllDatacenters, AllCopies")
      end
    end
  end

  # Name:         DeletedItemRetention
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_deleteditemretention) do
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         DomainController
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_domaincontroller) do
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         EventHistoryRetentionPeriod
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_eventhistoryretentionperiod) do
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         IndexEnabled
  # Type:         boolean
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_indexenabled) do
    validate do |value|
    end
    newvalues(true, false)
    munge do |value|
      provider.munge_boolean(value.to_s)
    end
  end

  # Name:         IsExcludedFromProvisioning
  # Type:         boolean
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_isexcludedfromprovisioning) do
    validate do |value|
    end
    newvalues(true, false)
    munge do |value|
      provider.munge_boolean(value.to_s)
    end
  end

  # Name:         IssueWarningQuota
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_issuewarningquota) do
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         IsSuspendedFromProvisioning
  # Type:         boolean
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_issuspendedfromprovisioning) do
    validate do |value|
    end
    newvalues(true, false)
    munge do |value|
      provider.munge_boolean(value.to_s)
    end
  end

  # Name:         JournalRecipient
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_journalrecipient) do
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         MailboxRetention
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_mailboxretention) do
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         MountAtStartup
  # Type:         boolean
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_mountatstartup) do
    validate do |value|
    end
    newvalues(true, false)
    munge do |value|
      provider.munge_boolean(value.to_s)
    end
  end

  # Name:         OfflineAddressBook
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_offlineaddressbook) do
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         ProhibitSendQuota
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_prohibitsendquota) do
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         ProhibitSendReceiveQuota
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_prohibitsendreceivequota) do
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         RecoverableItemsQuota
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_recoverableitemsquota) do
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         RecoverableItemsWarningQuota
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_recoverableitemswarningquota) do
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         RetainDeletedItemsUntilBackup
  # Type:         boolean
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_retaindeleteditemsuntilbackup) do
    validate do |value|
    end
    newvalues(true, false)
    munge do |value|
      provider.munge_boolean(value.to_s)
    end
  end


end
