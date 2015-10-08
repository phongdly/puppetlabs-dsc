require 'erb'
require 'dsc_utils'
require 'securerandom'
require 'master_manipulator'
test_name 'MODULES-2608 - C93342 - Apply DSC Manifest for Creating an Exchange Server'

#confine(:to, :platform => 'windows')

# Init
exch_setup_file = 'exchange2013_sp1_x64.iso'
exch_dl_url = 'http://int-resources.ops.puppetlabs.net/QA_resources/exchange_server_2013/mu_exchange_server_2013_with_sp1_x64_dvd_4059293.iso'
exch_dl_path = "C:\\#{exch_setup_file}"


user = 'Administrator'
user_password   = 'Qu@lity!'

ad_services_name    = 'AD-Domain-Services'
ad_gui_tools        = 'RSAT-ADDS'
domain_name         = SecureRandom.hex(4) + '.local'
puts "domain name #{domain_name}"

pp = <<-MANIFEST
dsc_script{ 'download_exchange_installer':
  dsc_getscript  => 'return @{}',
  dsc_testscript => "Test-Path '#{exch_dl_path}'",
  dsc_setscript  => "(New-Object Net.WebClient).DownloadFile('#{exch_dl_url}', '#{exch_dl_path}')"
}
->
dsc_windowsfeature { 'ad_domain_services':
  dsc_ensure  => 'Present',
  dsc_name    => "#{ad_services_name}"
}
->
dsc_windowsfeature { 'ad_gui_tools':
  dsc_ensure  => 'Present',
  dsc_name    => "#{ad_gui_tools}"
}
->
dsc_xaddomain { 'create_domain':
  dsc_domainname                    => "#{domain_name}",
  dsc_domainadministratorcredential => {'user' => "#{user}", 'password' => "#{user_password}"},
  dsc_safemodeadministratorpassword => {'user' => "#{user}", 'password' => "#{user_password}"},
}
~>
reboot { 'after_ad_configuration':
  apply  => finished
}

MANIFEST

step 'Install the reboot module on the master:'
on(master, "puppet module install puppetlabs-reboot") do |result|
  assert_no_match(/Error:/, result.stderr, 'Unexpected error was detected!')
end

step 'Inject "site.pp" on Master'
site_pp = create_site_pp(master, :manifest => pp)
inject_site_pp(master, get_site_pp_path(master), site_pp)

step 'Run Puppet Agent to install Active Directory'
confine_block(:to, :platform => 'windows') do
  agents.each do |agent|
    on(agent, puppet('agent -t --debug --environment production'), :stdin => pp, :acceptable_exit_codes => [0,2]) do |result|
      assert_no_match(/Error:/, result.stderr, 'Unexpected error was detected!')
    end
  end
end

