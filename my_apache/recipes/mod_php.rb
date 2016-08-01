# installs mod_php

ruby_block 'start' do
	block do
		Chef::Log.warn('my_apache::mod_php  START')
	end
end

package 'libapache2-mod-php5' do
  action :install
end

ruby_block 'stop' do
	block do
		Chef::Log.warn('my_apache::mod_php  END')
	end
end
