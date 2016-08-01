# this will install mod_headers

ruby_block 'start' do
	block do
		Chef::Log.warn('my_apache::mod_headers  START')
	end
end

my_apache_module 'headers'

ruby_block 'stop' do
	block do
		Chef::Log.warn('my_apache::mod_headers  END')
	end
end
