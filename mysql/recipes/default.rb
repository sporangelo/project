# stop if there's no csproject_environment definition
csproject_env = node[:csproject_environment]
if csproject_env == nil
        Chef::Log.fatal('uwsgi: ERROR: the JSON has no csproject_environment definition')
        raise
end

# fail if there's no username specified
user = csproject_env[:username]
if user == nil
        Chef::Log.fatal('uwsgi: ERROR: the JSON has no username definition')
        raise
end

# Install mysql
%W(mysql-client-core-5.6 mysql-client-5.6 mysql-server-5.6).each do |pack|
  package pack do
    action :install
  end
end

service 'mysql' do
  action [:start, :enable]
  supports :status => true, :start => true, :stop => true, :restart => true, :enable => true
end
