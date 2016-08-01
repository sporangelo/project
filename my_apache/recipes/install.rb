# recipe to install apache

ruby_block 'start' do
	block do
		Chef::Log.warn('my_apache::install  START')
	end
end

package 'apache2' do
  action :install
end

ruby_block 'stop' do
	block do
		Chef::Log.warn('my_apache::install  END')
	end
end
