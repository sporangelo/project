# installs the mod_auth_digest module

ruby_block 'start' do
	block do
		Chef::Log.warn('my_apache::mod_auth_digest  START')
	end
end

my_apache_module 'auth_digest'

ruby_block 'stop' do
	block do
		Chef::Log.warn('my_apache::mod_auth_digest  END')
	end
end
