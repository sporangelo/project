# Cookbook Name:: alfresco_mysql
# Recipe:: install

ruby_block 'start' do
  block do
    Chef::Log.warn('alfresco_mysql::install START')
  end
end

%W(mysql-client-core-5.6 mysql-client-5.6 mysql-server-5.6).each do |pack|
  package pack do
    action :install
  end
end

ruby_block 'stop' do
  block do
    Chef::Log.warn('alfresco_mysql:install END')
  end
end
