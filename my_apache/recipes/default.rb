# Recipe:: default
#
# Copyright 2015, Silvian Cretu
#
# All rights reserved - Do Not Redistribute
#


# stop if there's no pbs_environment definition
pbs_env = node[:pbs_environment]
if pbs_env == nil
	Chef::Log.fatal('my_apache: ERROR: the JSON has no pbs_environment definition')
	raise
end

# fail if there's no username specified
user = pbs_env[:username]
if user == nil
	Chef::Log.fatal('my_apache: ERROR: the JSON has no username definition')
	raise
end

# check if we have the required attribute values set
conf_dir = node['my_apache']['dir']
if conf_dir == nil
	Chef::Log.fatal('ERROR: my_apache::dir attribute missing')
	raise
end

ruby_block 'start' do
	block do
		Chef::Log.warn('my_apache: START, including my_apache::install first')
	end
end

home = "/home/#{user}"

include_recipe 'my_apache::install'

#default apache configuration

template '/etc/apache2/apache2.conf' do
  source 'apache2.conf.erb'
end
template '/etc/apache2/ports.conf' do
  source 'ports.conf.erb'
  variables :apache_port_nr => "#{node['my_apache']['apache_port_nr']}"
end

cookbook_file '/etc/apache2/conf-available/security.conf' do
  mode '644'
  owner 'root'
  group 'root'
  source 'security.conf'
  action :create
end

%w(default default.conf 000-default 000-default.conf).each do |site|
	link "#{conf_dir}/sites-enabled/#{site}" do
		action :delete
	end

	file "#{conf_dir}/sites-available/#{site}" do
		action :delete
		backup false
	end
end

# enable default zzz site and the required modules for it
include_recipe 'my_apache::mod_headers'

# enable default MPM: event
include_recipe 'my_apache::mpm_event'

# create the default config file for a template
template "#{conf_dir}/sites-available/zzz-default.conf" do
  owner 'root'
  group node['my_apache']['root_group']
  mode '0644'
        variables ( {
                :x_pbs_svrname => node['my_apache']['headers']['x_pbs_svrname'],
                :x_pbs_svrip   => node['my_apache']['headers']['x_pbs_svrip']
                  } )
end

# create the necessary directories
%W(#{home}/apache2 #{home}/apache2/conf.d #{home}/webroot).each do |path|
	directory path do
		owner "#{user}"
		group 'users'
		mode '0755'
		recursive true
		action :create
		not_if { Dir.exists?(path) }
	end
end

# enable the default site
my_apache_site "zzz-default" do
  enable true
end

# tweak the logrotate config
template '/etc/logrotate.d/apache2' do
	source 'logrotate.erb'
	action :create
        variables ( {
	        :logrotate_nr_of_days => node['my_apache']['logrotate']['nr_of_days'],
	        :logrotate_size       => node['my_apache']['logrotate']['size']
	          } )
end

# configure Apache to start at boot
include_recipe 'my_apache::service'

ruby_block 'stop' do
	block do
		Chef::Log.warn('my_apache  END')
	end
end
