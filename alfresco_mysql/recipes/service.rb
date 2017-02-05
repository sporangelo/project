# Cookbook Name:: alfresco_mysql
# Recipe:: service

service 'mysql' do
  provider Chef::Provider::Service::Upstart
  action :enable
  supports :status => true, :start => true, :stop => true, :restart => true, :enable => true
end
