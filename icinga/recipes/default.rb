include_recipe 'apt'

apt_repository 'nginx' do
  uri          'ppa:formorer/icinga'
  distribution node['lsb']['codename']
end

# Install packages needed by chef12 opsworks stack
%w{postfix bsd-mailx apache2 mysql-server libdbd-mysql mysql-client icinga}.each do |pkg|
  package pkg do
    action :install
  end
end
