# installs the mod_proxy module

ruby_block 'start' do
	block do
		Chef::Log.warn('my_apache::mod_proxy_fcgi  START')
	end
end

my_apache_module 'proxy_fcgi'

execute 'a2enmod proxy_fcgi' do
	action :run
end

ruby_block 'stop' do
	block do
		Chef::Log.warn('my_apache::mod_proxy_fcgi  END')
	end
end
