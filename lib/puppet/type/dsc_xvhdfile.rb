require 'pathname'

Puppet::Type.newtype(:dsc_xvhdfile) do
  require Pathname.new(__FILE__).dirname + '../../' + 'puppet/type/base_dsc'

  provide :powershell, :parent => Puppet::Type.type(:base_dsc).provider(:powershell) do
    defaultfor :operatingsystem => :windows
  end

  @doc = %q{
    The DSC xVhdFile resource type.
    Originally generated from the following schema.mof file:
      import/dsc_resources/xHyper-V/DSCResources/MSFT_xVhdFileDirectory/MSFT_xVhdFileDirectory.schema.mof
  }

  validate do
      fail('dsc_vhdpath is a required attribute') if self[:dsc_vhdpath].nil?
    end

  newparam(:dscmeta_resource_friendly_name) do
    defaultto "xVhdFile"
  end

  newparam(:dscmeta_resource_name) do
    defaultto "MSFT_xVhdFileDirectory"
  end

  newparam(:dscmeta_import_resource) do
    newvalues(true, false)

    munge do |value|
      provider.munge_boolean(value.to_s)
    end

    defaultto true
  end

  newparam(:dscmeta_module_name) do
    defaultto "xHyper-V"
  end

  newparam(:dscmeta_module_version) do
    defaultto "3.1.0.0"
  end

  newparam(:name, :namevar => true ) do
  end

  ensurable do
    newvalue(:exists?) { provider.exists? }
    newvalue(:present) { provider.create }
    defaultto { :present }
  end

  # Name:         VhdPath
  # Type:         string
  # IsMandatory:  True
  # Values:       None
  newparam(:dsc_vhdpath) do
    def mof_type; 'string' end
    def mof_is_embedded?; false end
    desc "Path to the VHD"
    isrequired
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
    end
  end

  # Name:         FileDirectory
  # Type:         string[]
  # IsMandatory:  False
  # Values:       None
  newparam(:dsc_filedirectory, :array_matching => :all) do
    def mof_type; 'string[]' end
    def mof_is_embedded?; true end
    def mof_type_map
      {"destinationpath"=>{:type=>"string"}, "sourcepath"=>{:type=>"string"}, "ensure"=>{:type=>"string", :values=>["Present", "Absent"]}, "type"=>{:type=>"string", :values=>["File", "Directory"]}, "recurse"=>{:type=>"boolean"}, "force"=>{:type=>"boolean"}, "content"=>{:type=>"string"}, "attributes"=>{:type=>"string[]", :values=>["ReadOnly", "Hidden", "System", "Archive"]}}
    end
    desc "The FileDirectory objects to copy to the VHD"
    validate do |value|
      unless value.kind_of?(Array) || value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string or an array of strings")
      end
    end
    munge do |value|
      Array(value)
    end
  end

  # Name:         CheckSum
  # Type:         string
  # IsMandatory:  False
  # Values:       ["ModifiedDate", "SHA-1", "SHA-256", "SHA-512"]
  newparam(:dsc_checksum) do
    def mof_type; 'string' end
    def mof_is_embedded?; false end
    validate do |value|
      unless value.kind_of?(String)
        fail("Invalid value '#{value}'. Should be a string")
      end
      unless ['ModifiedDate', 'modifieddate', 'SHA-1', 'sha-1', 'SHA-256', 'sha-256', 'SHA-512', 'sha-512'].include?(value)
        fail("Invalid value '#{value}'. Valid values are ModifiedDate, SHA-1, SHA-256, SHA-512")
      end
    end
  end


end
