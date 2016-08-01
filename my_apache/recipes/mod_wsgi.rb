# installs apache's mod_wsgi module

ruby_block 'start' do
	block do
		Chef::Log.warn('my_apache::mod_wsgi  START')
	end
end

package 'libapache2-mod-wsgi' do
  action :install
end

ruby_block 'stop' do
	block do
		Chef::Log.warn('my_apache::mod_wsgi  END')
	end
end
