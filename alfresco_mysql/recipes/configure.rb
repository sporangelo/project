# Cookbook Name:: alfresco_mysql
# Recipe:: configure

include_recipe 'alfresco_mysql::service'

pbs_env = nil
user = nil
pass = nil

if node.has_key?('pbs_environment')
  pbs_env = node['pbs_environment']
else
  Chef::Log.fatal('alfresco_mysql::configure: ERROR: no pbs_environment defined')
  raise
end

if pbs_env.has_key?('username')
  user = node['pbs_environment']['username']
  pass = node['pbs_environment']['password']
else
  Chef::Log.fatal('alfresco_mysql::configure: ERROR: no username defined')
  raise
end

Chef::Log.info('---- step 1 -----')
if pbs_env.has_key?('dbschema')
	# take the database info from the json
	databases = pbs_env[:dbschema]
else
	databases = nil
end

layer = node['opsworks']['instance']['layers'][0]

Chef::Log.info('---- step 2 ----')
# check if we have some overrides from the attributes
if node.has_key?(layer)
	l = node[layer]
	Chef::Log.info("layer: #{layer}")
	if l.has_key?('dbschema')
		# take the multiple db definition from attributes (hash)
		databases = l['dbschema']
		Chef::Log.info('database list:')
		Chef::Log.info(databases);
	end
end

if pbs_env.has_key?('mysql_root')
	mysql_root = pbs_env[:mysql_root]
else
	mysql_root = nil
end

# split the db list into an array to allow multiple databases

ebs = '/mnt/ebs'

# change the debian-sys-maint password
bash 'debian-sys-maint Password change' do
  code <<-EOL
    mysql -e "GRANT ALL PRIVILEGES on *.* TO 'debian-sys-maint'@'localhost' IDENTIFIED BY '#{mysql_root}' WITH GRANT OPTION; FLUSH PRIVILEGES;"
  EOL
  not_if { Dir.exist?("#{ebs}/mysql") || mysql_root.nil? }
end

case databases
	# old style, list of DB's with the same user/pass
	when Array
		Chef::Log.info('alfresco_mysql: simple database configuration using an array')
		databases.each do | database |
			Chef::Log.info("alfresco_mysql: granting privileges to #{user} to #{database}")
			bash 'default password change' do
				code <<-EOL
	    mysql -e "GRANT ALL privileges on #{database}.* to '#{user}'@'localhost' identified by '#{pass}'; FLUSH PRIVILEGES;"
				EOL
				not_if { pass.nil? }
			end
		end

	# new style, can have multiple DBs with separate user/pass settings
	when Hash
		Chef::Log.info('alfresco_mysql: complex configuration using a Hash')
		databases.each do | database, cred |
			db_user = cred['user']
			db_pass = cred['pass']
			Chef::Log.info("alfresco_mysql: granting privileges to #{db_user} to #{database}")
			bash 'default password change' do
				code <<-EOL
		    mysql -e "GRANT ALL privileges on #{database}.* to '#{db_user}'@'localhost' identified by '#{db_pass}'; FLUSH PRIVILEGES;"
				EOL
				not_if { pass.nil? }
			end
		end

	else
		Chef::Log.fatal('alfresco_mysql: invalid database definiton. It should be either an Array or Hash')
		raise
end


# change the mysql root password
bash 'mysql root password change' do
  code <<-EOL
    mysqladmin -uroot password #{mysql_root}
  EOL
  not_if { Dir.exist?("#{ebs}/mysql") || mysql_root.nil? }
end

template '/etc/mysql/debian.cnf' do
  source 'sys-maint.erb'
  owner 'root'
  group 'root'
  mode '0600'
end

service 'mysql' do
  action :stop
end

bash 'Copy entire directory from var lib' do
  code <<-EOL
 rm -f /var/lib/mysql/ibdata*
 rm -f /var/lib/mysql/ib_logfile*
 mv /var/lib/mysql #{ebs}/
 ln -s #{ebs}/mysql /var/lib/mysql
  EOL
  not_if { Dir.exist?("#{ebs}/mysql") }
end

template '/etc/mysql/my.cnf' do
  source 'my.cnf.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

# tunning ulimit
ulimit = `sysctl -n fs.file-max`.to_i/3
template '/etc/security/limits.d/mysql.conf' do
  source 'limits.mysql.erb'
  owner 'root'
  group 'root'
  mode '0644'
  variables(
      :ulimit => ulimit
  )
end

template '/root/.my.cnf' do
  source 'rootmy.cnf.erb'
  owner 'root'
  group 'root'
  mode '0700'
end

template '/etc/apparmor.d/tunables/alias' do
  source 'apparmor.alias.erb'
  owner 'root'
  group 'root'
  mode '0644'
  variables(
      :ebs_home => "#{ebs}/mysql/"
  )
end

template '/etc/apparmor.d/local/usr.sbin.mysqld' do
  source 'apparmor.local.erb'
  owner 'root'
  group 'root'
  mode '0644'
  variables(
      :allow_private => "#{ebs}/#{user}/etc/mysqld/"
  )
end

service 'apparmor' do
  supports :restart => true, :start => true, :stop => true, :reload => true
  action [:enable, :restart]
end

# create the necessary directories
%W(/home/#{user}/etc /home/#{user}/etc/mysqld).each do |path|
  directory path do
    owner user
    group 'users'
    mode '0755'
    recursive true
    action :create
  end
end

# removing initial directory
directory '/var/lib/mysql' do
  recursive true
  action :delete
end

# fixing link
link '/var/lib/mysql' do
  to '/mnt/ebs/mysql'
end

# fixing permissions because they will be lost
execute 'chown mysql' do
  command "chown -R mysql:mysql #{ebs}/mysql"
  user 'root'
  action :run
  only_if { Dir.exist?("#{ebs}/mysql") }
end

service 'mysql' do
  action :start
end
