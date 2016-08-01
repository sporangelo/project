# installs apache in pre-fork mode

ruby_block 'start' do
	block do
		Chef::Log.warn('my_apache::mpm_prefork  START')
	end
end

my_apache_module('mpm_event') { enable false }
my_apache_module 'mpm_prefork' do
  conf true
  restart true
end

ruby_block 'stop' do
	block do
		Chef::Log.warn('my_apache::mpm_prefork  END')
	end
end
