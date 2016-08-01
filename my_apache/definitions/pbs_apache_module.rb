define :my_apache_module, :enable => true, :conf => false, :restart => false do
  include_recipe 'my_apache::default'

  params[:filename]    = params[:filename] || "mod_#{params[:name]}.so"
  params[:module_path] = params[:module_path] || "#{node['my_apache']['libexec_dir']}/#{params[:filename]}"
  params[:identifier]  = params[:identifier] || "#{params[:name]}_module"

  my_apache_mod params[:name] if params[:conf]

  file "#{node['my_apache']['dir']}/mods-available/#{params[:name]}.load" do
    content "LoadModule #{params[:identifier]} #{params[:module_path]}\n"
    mode '0644'
  end

  if params[:enable]
    execute "a2enmod #{params[:name]}" do
      command "/usr/sbin/a2enmod #{params[:name]}"
      if params[:restart]
        notifies :restart, 'service[apache2]', :delayed
      else
        notifies :reload, 'service[apache2]', :delayed
      end
      not_if do
        ::File.symlink?("#{node['my_apache']['dir']}/mods-enabled/#{params[:name]}.load") &&
          (::File.exist?("#{node['my_apache']['dir']}/mods-available/#{params[:name]}.conf") ? ::File.symlink?("#{node['my_apache']['dir']}/mods-enabled/#{params[:name]}.conf") : true)
      end
    end
  else
    execute "a2dismod #{params[:name]}" do
      command "/usr/sbin/a2dismod #{params[:name]}"
      if params[:restart]
        notifies :restart, 'service[apache2]', :delayed
      else
        notifies :reload, 'service[apache2]', :delayed
      end
      only_if { ::File.symlink?("#{node['my_apache']['dir']}/mods-enabled/#{params[:name]}.load") }
    end
  end
end
