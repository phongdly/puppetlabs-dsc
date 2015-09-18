require 'erb'
require 'dsc_utils'
test_name 'MODULES-2538 - C89507 - Apply DSC Manifest for Creating a MySql Database Server'

confine(:to, :platform => 'windows')

# Init

sqlserver_dl_url = 'http://int-resources.ops.puppetlabs.net/QA_resources/microsoft_sql/mysql-installer-community-5.6.17.0.msi'
sqlserver_dl_path = "C:\\mysql-installer.msi"
sqlserver_install_path = "C:\\sqlserverPL"
user = 'admin01'
user_password = 'P@ssw0rd!'

agents.each do |agent|

pp = <<-MANIFEST
dsc_script{ 'download_sqlserver_msi':
  dsc_getscript  => 'return @{}',
  dsc_testscript => "Test-Path '#{sqlserver_dl_path}'",
  dsc_setscript  => "(New-Object Net.WebClient).DownloadFile('#{sqlserver_dl_url}', '#{sqlserver_dl_path}')"
}
->
dsc_package { 'mysql_source':
  dsc_ensure    => 'Present',
  dsc_path      => "#{sqlserver_dl_path}",
  dsc_name      => "MySQL Installer",
  dsc_productid => '',
  dsc_arguments => "/S /D=#{sqlserver_install_path}"
}
->
dsc_user{ 'create_admin_user':
  dsc_ensure    => 'Present',
  dsc_username  => '#{user}',
  dsc_disabled  => 'false',
}
->
dsc_group { 'create_test_group':
  dsc_ensure    => 'Present',
  dsc_groupname => 'Administrators',
  dsc_memberstoinclude   => ['#{user}']
}
->
dsc_xmysqlserver{'mysql_instance':
  dsc_ensure        => 'Present',
  dsc_servicename   => 'MSSQLSERVER01',
  dsc_rootpassword  => {'user' => '#{user}', 'password' => '#{user_password}'},
}

MANIFEST

puts pp
  step 'runscript to install mysql'
  on(agent, puppet('apply', '--debug'), :stdin => pp, :acceptable_exit_codes => [0,2]) do |result|
    assert_no_match(/Error:/, result.stderr, 'Unexpected error was detected!')
  end
end

