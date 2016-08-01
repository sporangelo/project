# installs the mod_proxy module

ruby_block 'start' do
	block do
		Chef::Log.warn('my_apache::mod_proxy_http  START')
	end
end

my_apache_module 'proxy_http'

ruby_block 'stop' do
	block do
		Chef::Log.warn('my_apache::mod_proxy_http  END')
	end
end
