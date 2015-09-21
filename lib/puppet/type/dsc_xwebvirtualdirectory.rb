require 'pathname'

Puppet::Type.newtype(:dsc_xwebvirtualdirectory) do
  require Pathname.new(__FILE__).dirname + '../../' + 'puppet/type/base_dsc'

  provide :powershell, :parent => Puppet::Type.type(:base_dsc).provider(:powershell) do
    defaultfor :operatingsystem => :windows
  end

  @doc = %q{
    The DSC xWebVirtualDirectory resource type.
    Originally generated from the following schema.mof file:
      import/dsc_resources/xWebAdministration/DSCResources/MSFT_xWebVirtualDirectory/MSFT_xWebVirtualDirectory.schema.mof
  }

  validate do
      fail('dsc_website is a required attribute') if self[:dsc_website].nil?
      fail('dsc_webapplication is a required attribute') if self[:dsc_webapplication].nil?
      fail('dsc_name is a required attribute') if self[:dsc_name].nil?
    end

  newparam(:dscmeta_resource_friendly_name) do
    defaultto "xWebVirtualDirectory"
  end

  newparam(:dscmeta_resource_name) do
    defaultto "MSFT_xWebVirtualDirectory"
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

  # Name:         Website
  # Type:         string
  # IsMandatory:  True
  # Values:       None
  newparam(:dsc_website) do
    def mof_type; 'string' end
    def mof_is_embedded?; false end
    desc "Name of website with which Web Application is associated"
    isrequired
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         WebApplication
  # Type:         string
  # IsMandatory:  True
  # Values:       None
  newparam(:dsc_webapplication) do
    def mof_type; 'string' end
    def mof_is_embedded?; false end
    desc "Web application name for the virtual directory"
    isrequired
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
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
    desc "Name of virtual directory"
    isrequired
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         PhysicalPath
  # Type:         string
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_physicalpath) do
    def mof_type; 'string' end
    def mof_is_embedded?; false end
    desc "Physical path for the virtual directory"
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
    desc "Whether virtual directory should be present or absent"
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


end
