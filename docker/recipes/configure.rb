# Create folder structure

  directory "/home/ubuntu/dockerbuilds/http" do
    owner 'ubuntu'
    group 'ubuntu'
    mode '0755'
    action :create
    recursive true
  end

    directory "/home/ubuntu/dockerbuilds/mysql" do
      owner 'ubuntu'
      group 'ubuntu'
      mode '0755'
      action :create
      recursive true
    end

# Upload http files for docker
template "/home/ubuntu/dockerbuilds/http/apache2.conf" do
  user 'root'
  group 'root'
  mode '0777'
  source 'http/apache2.conf'
end
template "/home/ubuntu/dockerbuilds/http/Dockerfile" do
  user 'root'
  group 'root'
  mode '0777'
  source 'http/Dockerfile'
end
template "/home/ubuntu/dockerbuilds/http/docker-start-http.sh" do
  user 'root'
  group 'root'
  mode '0777'
  source 'http/docker-start-http.sh'
end
template "/home/ubuntu/dockerbuilds/http/.htpasswd" do
  user 'root'
  group 'root'
  mode '0777'
  source 'http/.htpasswd'
end
template "/home/ubuntu/dockerbuilds/http/logs.sh" do
  user 'root'
  group 'root'
  mode '0777'
  source 'http/logs.sh'
end

# Upload mysql files for docker
template "/home/ubuntu/dockerbuilds/mysql/docker-start-mysql.sh" do
  user 'root'
  group 'root'
  mode '0777'
  source 'mysql/docker-start-mysql.sh'
end
template "/home/ubuntu/dockerbuilds/mysql/Dockerfile" do
  user 'root'
  group 'root'
  mode '0777'
  source 'mysql/Dockerfile'
end
template "/home/ubuntu/dockerbuilds/mysql/my.cnf" do
  user 'root'
  group 'root'
  mode '0777'
  source 'mysql/my.cnf'
end
template "/home/ubuntu/dockerbuilds/mysql/logs.sh" do
  user 'root'
  group 'root'
  mode '0777'
  source 'mysql/logs.sh'
end
