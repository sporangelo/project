define :my_apache_mod do
  include_recipe 'my_apache::default'

  template "#{node['my_apache']['dir']}/mods-available/#{params[:name]}.conf" do
    source "mods/#{params[:name]}.conf.erb"
    mode '0644'
    notifies :reload, 'service[apache2]', :delayed
  end
end
