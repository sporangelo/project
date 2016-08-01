# installs the mod_proxy module

ruby_block 'start' do
	block do
		Chef::Log.warn('my_apache::mod_remoteip  START')
	end
end

my_apache_module 'remoteip'

ruby_block 'stop' do
	block do
		Chef::Log.warn('my_apache::mod_remoteip  END')
	end
end
