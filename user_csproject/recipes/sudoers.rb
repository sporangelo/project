ruby_block 'start' do
  block do
    Chef::Log.warn('csproject_username::sudoers START')
  end
end

template '/etc/sudoers.d/csproject_sudo' do
  source 'csproject_sudo.erb'
  mode '0440'
  owner 'root'
  group 'root'
  variables :commands => node[:csproject_environment][:sudo].join(',')
end

ruby_block 'start' do
  block do
    Chef::Log.warn('csproject_username::sudoers END')
  end
end
