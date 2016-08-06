#
# Cookbook Name:: icinga2
# Recipe:: service
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

service 'icinga2' do
  service_name node['icinga2']['service_name']
  supports :status => true, :reload => true, :restart => true
  action [:enable]
end

ruby_block 'delayed_icinga2_service_start' do
  block do
  end
  notifies :start, 'service[icinga2]', :delayed
end
