# installs the mod_include module

ruby_block 'start' do
	block do
		Chef::Log.warn('my_apache::mod_include  START')
	end
end

my_apache_module 'include'

ruby_block 'stop' do
	block do
		Chef::Log.warn('my_apache::mod_include  END')
	end
end
