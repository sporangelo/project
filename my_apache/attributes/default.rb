# Where the various parts of apache are
case node['platform']
when 'ubuntu'
  default['my_apache']['dir']		= '/etc/apache2'
  default['my_apache']['root_group']	= 'root'
  default['my_apache']['lib_dir']	= '/usr/lib/apache2'
  default['my_apache']['libexec_dir']	= "#{node['my_apache']['lib_dir']}/modules"
  default['my_apache']['apache_port_nr']  = '80'
  default['my_apache']['logrotate']['nr_of_days'] = '10'
  # default['my_apache']['logrotate']['size'] = 'size = 256M'
  default['my_apache']['headers']['x_pbs_svrname'] = 'X-PBS-appsvrname'
  default['my_apache']['headers']['x_pbs_svrip'] = 'X-PBS-appsvrip'

end

