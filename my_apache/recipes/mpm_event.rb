# installs the apache's mpm_event module

ruby_block 'start' do
	block do
		Chef::Log.warn('my_apache::mpm_event  START')
	end
end

my_apache_module('mpm_prefork') { enable false }
my_apache_module 'mpm_event' do
  conf true
  restart true
end

ruby_block 'stop' do
	block do
		Chef::Log.warn('my_apache::mpm_event  END')
	end
end
