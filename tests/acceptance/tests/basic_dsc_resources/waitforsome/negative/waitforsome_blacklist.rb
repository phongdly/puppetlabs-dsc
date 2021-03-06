require 'erb'
require 'dsc_utils'
test_name 'MODULES-2399 - C71647 - Attempt to Apply DSC WaitForSome Resource'

confine(:to, :platform => 'windows')

# Init
local_files_root_path = ENV['MANIFESTS'] || 'tests/manifests'

# ERB Manifest
dsc_type = 'waitforsome'
dsc_props = {
  :dsc_nodename     => 'localhost',
  :dsc_resourcename => 'does_not_matter'
}

dsc_manifest_template_path = File.join(local_files_root_path, 'basic_dsc_resources', 'dsc_single_resource.pp.erb')
dsc_manifest = ERB.new(File.read(dsc_manifest_template_path), 0, '>').result(binding)

# Verify
error_msg = /Error:.*Invalid resource type dsc_waitforsome/

# Tests
agents.each do |agent|
  step 'Attempt to Apply Manifest'
  on(agent, puppet('apply'), :stdin => dsc_manifest, :acceptable_exit_codes => 0) do |result|
    expect_failure('Expected to fail because of MODULES-2504') do
      assert_match(error_msg, result.stderr, 'Expected error was not detected!')
    end
  end
end
