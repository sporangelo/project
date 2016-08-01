define :my_apache_site, :enable => true do
  include_recipe 'my_apache'
  conf_name = "#{params[:name]}.conf"

  if params[:enable]
    execute "a2ensite #{conf_name}" do
      command "/usr/sbin/a2ensite #{conf_name}"
      notifies :reload, 'service[apache2]', :delayed
      not_if do
        ::File.symlink?("#{node['my_apache']['dir']}/sites-enabled/#{conf_name}") ||
        ::File.symlink?("#{node['my_apache']['dir']}/sites-enabled/000-#{conf_name}")
      end
      only_if { ::File.exist?("#{node['my_apache']['dir']}/sites-available/#{conf_name}") }
    end
  else
    execute "a2dissite #{conf_name}" do
      command "/usr/sbin/a2dissite #{conf_name}"
      notifies :reload, 'service[apache2]', :delayed
      only_if do
        ::File.symlink?("#{node['my_apache']['dir']}/sites-enabled/#{conf_name}") ||
        ::File.symlink?("#{node['my_apache']['dir']}/sites-enabled/000-#{conf_name}")
      end
    end
  end
end
