# installs mod_php

ruby_block 'start' do
	block do
		Chef::Log.warn('my_apache::mod_php  START')
	end
end

package 'libapache2-mod-fastcgi' do
  action :install
end

execute 'a2enmod actions fastcgi alias' do
 action :run
end


ruby_block 'stop' do
	block do
		Chef::Log.warn('my_apache::mod_php  END')
	end
end
