# installs the mod_rewrite module

ruby_block 'start' do
	block do
		Chef::Log.warn('my_apache::mod_rewrite  START')
	end
end

my_apache_module 'rewrite'

ruby_block 'stop' do
	block do
		Chef::Log.warn('my_apache::mod_rewrite  END')
	end
end
