require 'pathname'

Puppet::Type.newtype(:dsc_xiismodule) do
  require Pathname.new(__FILE__).dirname + '../../' + 'puppet/type/base_dsc'

  provide :powershell, :parent => Puppet::Type.type(:base_dsc).provider(:powershell) do
    defaultfor :operatingsystem => :windows
  end

  @doc = %q{
    The DSC xIisModule resource type.
    Originally generated from the following schema.mof file:
      import/dsc_resources/xWebAdministration/DSCResources/MSFT_xIisModule/MSFT_xIisModule.schema.mof
  }

  validate do
      fail('dsc_path is a required attribute') if self[:dsc_path].nil?
    end

  newparam(:dscmeta_resource_friendly_name) do
    defaultto "xIisModule"
  end

  newparam(:dscmeta_resource_name) do
    defaultto "MSFT_xIisModule"
  end

  newparam(:dscmeta_import_resource) do
    newvalues(true, false)

    munge do |value|
      provider.munge_boolean(value.to_s)
    end

    defaultto true
  end

  newparam(:dscmeta_module_name) do
    defaultto "xWebAdministration"
  end

  newparam(:dscmeta_module_version) do
    defaultto "1.7.0.0"
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
    desc "The path to the module, usually a dll, to be added to IIS."
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
    desc "The logical name of the module to add to IIS."
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         RequestPath
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_requestpath) do
    def mof_type; 'string' end
    def mof_is_embedded?; false end
    desc "The allowed request Path example: *.php"
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         Verb
  # Type:         string[]
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_verb, :array_matching => :all) do
    def mof_type; 'string[]' end
    def mof_is_embedded?; false end
    desc "The supported verbs for the module."
    validate do |value|
      unless value.kind_of?(Array) || value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string or an array of strings")
      end
    end
    munge do |value|
      Array(value)
    end
  end

  # Name:         SiteName
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_sitename) do
    def mof_type; 'string' end
    def mof_is_embedded?; false end
    desc "The IIS Site to register the module."
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
    desc "Should the module be present or absent."
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

  # Name:         ModuleType
  # Type:         string
  # IsMandatory:  False
  # Values:       ["FastCgiModule"]
  newparam(:dsc_moduletype) do
    def mof_type; 'string' end
    def mof_is_embedded?; false end
    desc "The type of the module."
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
      unless ['FastCgiModule', 'fastcgimodule'].include?(value)
        fail("Invalid value '#{value}'. Valid values are FastCgiModule")
      end
    end
  end

  # Name:         EndPointSetup
  # Type:         boolean
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_endpointsetup) do
    def mof_type; 'boolean' end
    def mof_is_embedded?; false end
    desc "The End Point is setup.  Such as a Fast Cgi endpoint."
    validate do |value|
    end
    newvalues(true, false)
    munge do |value|
      provider.munge_boolean(value.to_s)
    end
  end


end
