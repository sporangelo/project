# look for the csproject_environment
csproject_env = node[:csproject_environment]
if csproject_env == nil
    # fail is there's no csproject_env defined
    Chef::Log.fatal('user_csproject: ERROR: no username was defined in the JSON')
    raise
end

# check if the username is defined
user_name = csproject_env[:username]
if user_name == nil
  # nope, we don't have a username definition.
  # complain about and throw an error
  Chef::Log.fatal('user_csproject: ERROR: no username was defined in the JSON')
  raise
end

# use the optional password, if set
password = nil
unless csproject_env[:password] == nil
    password = csproject_env[:password]
end

ruby_block 'start' do
    block do
        Chef::Log.warn("user_csproject  START,  creating user: #{user_name}")
    end
end

# create group
group user_name do
  action :create
end

# create the user
user user_name do
  supports :manage_home => true
  comment 'CONNECT Username'
  group user_name
  username user_name
  home "/home/#{user_name}"
  shell '/bin/bash'
end

# if the password was specified change it via BASH commands, as the Chef way, fails
bash 'passwd' do
  user 'root'
  not_if { password == nil }
  code <<-EOH
    echo '#{user_name}:#{password}' | /usr/sbin/chpasswd
  EOH
end
