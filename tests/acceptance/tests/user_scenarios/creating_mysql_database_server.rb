require 'erb'
require 'dsc_utils'
require 'securerandom'

test_name 'MODULES-2538 - C89507 - Apply DSC Manifest for Creating a MySql Database Server'

confine(:to, :platform => 'windows')

# Init
sqlserver_dl_url = 'http://int-resources.ops.puppetlabs.net/QA_resources/microsoft_sql/mysql-installer-community-5.6.17.0.msi'
sqlserver_dl_path = "C:\\mysql-installer.msi"
#user = 'Admin' + SecureRandom.hex(2)
#user = 'Administrator'
#user = 'root'
#user_password   = 'P@ssw0rd!' + SecureRandom.hex(3)
#user_password = 'Q@lity!'
# mysql_instance  = 'mysql' + SecureRandom.hex(2)
# database_name   = 'DB' + SecureRandom.hex(3)
# table_name      = 'Table' + SecureRandom.hex(2)

user = 'Admin99'
user_password = 'password'
mysql_instance = 'MSSQLSERVER001'
database_name = 'database001pl'
table_name = 'testtable'

puts "user: #{user}"
puts "Password #{user_password}"
puts "instance #{mysql_instance}"
puts "Database name: #{database_name}"

agents.each do |agent|

pp = <<-MANIFEST
dsc_script{ 'download_sqlserver_msi':
  dsc_getscript  => 'return @{}',
  dsc_testscript => "Test-Path '#{sqlserver_dl_path}'",
  dsc_setscript  => "(New-Object Net.WebClient).DownloadFile('#{sqlserver_dl_url}', '#{sqlserver_dl_path}')"
}
->
dsc_package {'mysql_source':
  dsc_path      => "#{sqlserver_dl_path}",
  dsc_productid => '437AC169-780B-47A9-86F6-14D43C8F596B',
  dsc_name      => "MySQL Installer",
  dsc_ensure    => 'Present',
}
->
dsc_user {'create_admin_user_#{user}':
  dsc_ensure    => 'Present',
  dsc_username  => '#{user}',
  dsc_disabled  => 'false',
}
->
dsc_group {'add_#{user}_to_admin_group':
  dsc_ensure    => 'Present',
  dsc_groupname => 'Administrators',
  dsc_memberstoinclude   => ['#{user}']
}
->
dsc_xmysqlserver {'mysql_instance_#{mysql_instance}':
  dsc_ensure        => 'Present',
  dsc_servicename   => 'MySQLInstanceServiceName',
  dsc_rootpassword  => {'user' => '#{user}', 'password' => '#{user_password}'},
}
->
dsc_xmysqldatabase {'create_database_#{database_name}':
  dsc_ensure  => 'Present',
  dsc_name    => '#{database_name}',
  dsc_connectioncredential => {'user' => '#{user}', 'password' => '#{user_password}'},
}
->
dsc_xmysqluser {'create_sqluser_#{user}':
  dsc_name => '#{user}',
  dsc_credential => {'user' => 'root', 'password' => '#{user_password}'},
  dsc_ensure => 'Present',
  dsc_connectioncredential => {'user' => 'root', 'password' => '#{user_password}'},
}
->
dsc_xmysqlgrant {'granting_#{user}_to_#{database_name}':
  dsc_username => '#{user}',
  dsc_databasename => '#{database_name}',
  dsc_permissiontype => 'ALL PRIVILEGES',
  dsc_ensure => 'Present',
  dsc_connectioncredential => {'user' => '#{user}', 'password' => '#{user_password}'},
}

MANIFEST

puts pp
  step 'runscript to install mysql'
  on(agent, puppet('apply', '--debug'), :stdin => pp, :acceptable_exit_codes => [0,2]) do |result|
    assert_no_match(/Error:/, result.stderr, 'Unexpected error was detected!')
  end

  step "Create a table, '#{table_name}' in database '#{database_name}':"
  cmd = "C:\\Program Files\\MySQL\\MySQL Server 5.6\\bin\\mysql.exe -u #{user} -p#{user_password} #{database_name} -e \"create table #{table_name} (name VARCHAR(20, owner VARCHAR(20));\""
  on(agent, "#{cmd}", :stdin => pp, :acceptable_exit_codes => [0,2]) do |result|
    assert_no_match(/Error:/, result.stderr, 'Unexpected error was detected!')
  end

  step "Show table, '#{table_name}' in database '#{database_name}':"
  cmd = "C:\\Program Files\\MySQL\\MySQL Server 5.6\\bin\\mysql.exe -u #{user} -p#{user_password} #{database_name} -e \"show tables;\""
  on(agent, "#{cmd}", :stdin => pp, :acceptable_exit_codes => [0,2]) do |result|
    assert_no_match(/Error:/, result.stderr, 'Unexpected error was detected!')
  end
end

