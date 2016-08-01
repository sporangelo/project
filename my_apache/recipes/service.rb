# recipe to configure apache to start on boot

ruby_block 'start' do
	block do
		Chef::Log.warn('my_apache::service  START')
	end
end

service 'apache2' do
  action :enable
  supports :status => true, :start => true, :stop => true, :restart => true, :enable => true
end

ruby_block 'stop' do
	block do
		Chef::Log.warn('my_apache::service  END')
	end
end
