require 'pathname'

Puppet::Type.newtype(:dsc_xwefsubscription) do
  require Pathname.new(__FILE__).dirname + '../../' + 'puppet/type/base_dsc'

  provide :powershell, :parent => Puppet::Type.type(:base_dsc).provider(:powershell) do
    defaultfor :operatingsystem => :windows
  end

  @doc = %q{
    The DSC xWEFSubscription resource type.
    Originally generated from the following schema.mof file:
      import/dsc_resources/xWindowsEventForwarding/DSCResources/MSFT_xWEFSubscription/MSFT_xWEFSubscription.schema.mof
  }

  validate do
      fail('dsc_subscriptionid is a required attribute') if self[:dsc_subscriptionid].nil?
    end

  newparam(:dscmeta_resource_friendly_name) do
    defaultto "xWEFSubscription"
  end

  newparam(:dscmeta_resource_name) do
    defaultto "MSFT_xWEFSubscription"
  end

  newparam(:dscmeta_import_resource) do
    newvalues(true, false)

    munge do |value|
      provider.munge_boolean(value.to_s)
    end

    defaultto true
  end

  newparam(:dscmeta_module_name) do
    defaultto "xWindowsEventForwarding"
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

  # Name:         SubscriptionID
  # Type:         string
  # IsMandatory:  True
  # Values:       None
  newparam(:dsc_subscriptionid) do
    desc "Name of the Subscription"
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
    desc "Determines whether to validate or remove the scubscription"
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

  # Name:         SubscriptionType
  # Type:         string
  # IsMandatory:  False
  # Values:       ["CollectorInitiated", "SourceInitiated"]
  newparam(:dsc_subscriptiontype) do
    desc "Type of Subscription to create"
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
      unless ['CollectorInitiated', 'collectorinitiated', 'SourceInitiated', 'sourceinitiated'].include?(value)
        fail("Invalid value '#{value}'. Valid values are CollectorInitiated, SourceInitiated")
      end
    end
  end

  # Name:         Description
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_description) do
    desc "Description of the Collector subscription"
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         Enabled
  # Type:         string
  # IsMandatory:  False
  # Values:       ["true", "false"]
  newparam(:dsc_enabled) do
    desc "Sets whether the subscription will be enabled, default true"
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
      unless ['true', 'true', 'false', 'false'].include?(value)
        fail("Invalid value '#{value}'. Valid values are true, false")
      end
    end
  end

  # Name:         DeliveryMode
  # Type:         string
  # IsMandatory:  False
  # Values:       ["Push", "Pull"]
  newparam(:dsc_deliverymode) do
    desc "Configures whether the collector will pull events from source nodes or if the source nodes will push events to the collector, default push"
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
      unless ['Push', 'push', 'Pull', 'pull'].include?(value)
        fail("Invalid value '#{value}'. Valid values are Push, Pull")
      end
    end
  end

  # Name:         MaxItems
  # Type:         sint32
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_maxitems) do
    desc "The number of events that can occur on the source before they are submitted to the collector, default 1"
    validate do |value|
      unless value.kind_of?(Numeric) || value.to_i.to_s == value || value.to_i >= 0
          fail("Invalid value #{value}. Should be a signed Integer")
      end
    end
    munge do |value|
      value.to_i
    end
  end

  # Name:         MaxLatencyTime
  # Type:         uint64
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_maxlatencytime) do
    desc "The maximum amount of time that can pass before events are submitted to the collector, default 20000"
    validate do |value|
      unless (value.kind_of?(Numeric) && value >= 0) || (value.to_i.to_s == value && value.to_i >= 0)
          fail("Invalid value #{value}. Should be a unsigned Integer")
      end
    end
    munge do |value|
      value.to_i
    end
  end

  # Name:         HeartBeatInterval
  # Type:         uint64
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_heartbeatinterval) do
    desc "Frequency to verify connectivity, default 20000"
    validate do |value|
      unless (value.kind_of?(Numeric) && value >= 0) || (value.to_i.to_s == value && value.to_i >= 0)
          fail("Invalid value #{value}. Should be a unsigned Integer")
      end
    end
    munge do |value|
      value.to_i
    end
  end

  # Name:         ReadExistingEvents
  # Type:         string
  # IsMandatory:  False
  # Values:       ["true", "false"]
  newparam(:dsc_readexistingevents) do
    desc "Should the collector read existing or only new events, default false"
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
      unless ['true', 'true', 'false', 'false'].include?(value)
        fail("Invalid value '#{value}'. Valid values are true, false")
      end
    end
  end

  # Name:         TransportName
  # Type:         string
  # IsMandatory:  False
  # Values:       ["HTTP", "HTTPS"]
  newparam(:dsc_transportname) do
    desc "Determines whether to require SSL, default HTTP"
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
      unless ['HTTP', 'http', 'HTTPS', 'https'].include?(value)
        fail("Invalid value '#{value}'. Valid values are HTTP, HTTPS")
      end
    end
  end

  # Name:         TransportPort
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_transportport) do
    desc "Set the port number that WinRM should use to make a connection, default 5985"
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         ContentFormat
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_contentformat) do
    desc "Format that event logs will be submitted in, default RenderedText"
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         Locale
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_locale) do
    desc "Sets the subscription Locale, default en-US"
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         LogFile
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_logfile) do
    desc "Sets the event log that the collected events will be written to, default ForwardedEvents"
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         CredentialsType
  # Type:         string
  # IsMandatory:  False
  # Values:       ["Default", "Basic", "Negotiate", "Digest"]
  newparam(:dsc_credentialstype) do
    desc "Sets the credential type used for authenticating to WinRM, default Default"
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
      unless ['Default', 'default', 'Basic', 'basic', 'Negotiate', 'negotiate', 'Digest', 'digest'].include?(value)
        fail("Invalid value '#{value}'. Valid values are Default, Basic, Negotiate, Digest")
      end
    end
  end

  # Name:         AllowedSourceNonDomainComputers
  # Type:         string[]
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_allowedsourcenondomaincomputers, :array_matching => :all) do
    desc "This parameter has not been fully implemented, only required for source initiated scenarios, provide XML to set IssuerCAList, AllowedSubjectList, or DeniedSubjectList if this will be used, default empty string"
    validate do |value|
      unless value.kind_of?(Array) || value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string or an array of strings")
      end
    end
    munge do |value|
      Array(value)
    end
  end

  # Name:         AllowedSourceDomainComputers
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_allowedsourcedomaincomputers) do
    desc "In Source Initiated scenario this SDDL determines who can push events, default O:NSG:NSD:(A;;GA;;;DC)(A;;GA;;;NS) which equates to Domain Computers and Network Service"
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         Query
  # Type:         string[]
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_query, :array_matching => :all) do
    desc "Expects an array of hashtables that set which events should be collected, default is all application and system logs"
    validate do |value|
      unless value.kind_of?(Array) || value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string or an array of strings")
      end
    end
    munge do |value|
      Array(value)
    end
  end

  # Name:         Address
  # Type:         string[]
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_address, :array_matching => :all) do
    desc "Expects an array of source node FQDNs, default source.wef.test to prevent errors when only staging test subscription"
    validate do |value|
      unless value.kind_of?(Array) || value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string or an array of strings")
      end
    end
    munge do |value|
      Array(value)
    end
  end


end
