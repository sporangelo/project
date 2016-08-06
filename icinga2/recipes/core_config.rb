#
# Cookbook Name:: icinga2
# Recipe:: core_config
#
# Copyright 2014, Virender Khatri
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

[node['icinga2']['conf_dir'],
 node['icinga2']['conf_d_dir'],
 node['icinga2']['pki_dir'],
 node['icinga2']['scripts_dir'],
 node['icinga2']['zones_dir'],
 node['icinga2']['objects_dir'],
 node['icinga2']['features_enabled_dir'],
 node['icinga2']['features_available_dir'],
 node['icinga2']['custom_plugins_dir']
].each do |d|
  directory d do
    owner node['icinga2']['user']
    group node['icinga2']['group']
    mode 0750
  end
end

node['icinga2']['user_defined_objects_dir'].each do |d|
  directory ::File.join(node['icinga2']['conf_dir'], d) do
    owner node['icinga2']['user']
    group node['icinga2']['group']
    mode 0750
  end
end

[node['icinga2']['log_dir'],
 node['icinga2']['run_dir'],
 ::File.join(node['icinga2']['log_dir'], 'compat'),
 ::File.join(node['icinga2']['log_dir'], 'compat', 'archives'),
 node['icinga2']['cache_dir']
].each do |d|
  directory d do
    owner node['icinga2']['user']
    group node['icinga2']['cmdgroup']
    mode 0750
  end
end

# icinga2 logrotate
template '/etc/logrotate.d/icinga2' do
  source 'icinga2.logrotate.erb'
  owner 'root'
  group 'root'
  mode 0644
  variables(:log_dir => node['icinga2']['log_dir'])
end

# icinga2.conf
template ::File.join(node['icinga2']['conf_dir'], 'icinga2.conf') do
  source 'icinga2.conf.erb'
  owner node['icinga2']['user']
  group node['icinga2']['group']
  mode 0644
  notifies :reload, 'service[icinga2]', :delayed
end

# icinga2 service config file
template node['icinga2']['service_config_file'] do
  source 'icinga2.service.config.erb'
  owner 'root'
  group 'root'
  mode 0644
  variables(:log_dir => node['icinga2']['log_dir'],
            :conf_dir => node['icinga2']['conf_dir'],
            :user => node['icinga2']['user'],
            :group => node['icinga2']['group'],
            :cmdgroup => node['icinga2']['cmdgroup']
           )
  notifies :reload, 'service[icinga2]', :delayed
end

# icinga2 service init config file
template ::File.join(node['icinga2']['conf_dir'], 'init.conf') do
  source 'icinga2.init.conf.erb'
  owner node['icinga2']['user']
  group node['icinga2']['group']
  mode 0644
  variables(:user => node['icinga2']['user'],
            :group => node['icinga2']['group']
           )
  notifies :reload, 'service[icinga2]', :delayed
end

# icinga2 constants config file
template ::File.join(node['icinga2']['conf_dir'], 'constants.conf') do
  source 'icinga2.constants.conf.erb'
  owner node['icinga2']['user']
  group node['icinga2']['group']
  mode 0644
  variables(:options => node['icinga2']['constants'])
  notifies :reload, 'service[icinga2]', :delayed
end
