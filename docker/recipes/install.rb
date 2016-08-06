# Install the last jenkins server
include_recipe 'apt'



# Install system packages
%w{docker-engine awscli expect}.each do |pkg|
  package pkg do
    action :install
  end
end

# Install optional configurations
script 'Install optional configurations' do
  interpreter 'bash'
  group 'root'
  user 'root'
  cwd '/var/lib'
  code <<-EOH
    set -e

    # Optional configurations
    # Add your user to docker group
    usermod -aG docker ubuntu
    # Configure a DNS server for use by Docker
    echo 'DOCKER_OPTS="--dns 8.8.8.8"' >> /etc/default/docker
    service docker restart
    sleep 5
  EOH
end

# Install ubuntu image
script 'Install ubuntu image' do
  interpreter 'bash'
  group 'root'
  user 'root'
  cwd '/home/ubuntu/dockerbuilds/http/'
  code <<-EOH
    set -e
    docker pull ubuntu:14.04
  EOH
end

# Install http image
script 'Install http image' do
  interpreter 'bash'
  group 'root'
  user 'root'
  cwd '/home/ubuntu/dockerbuilds/http/'
  code <<-EOH
    set -e
    docker build -t my_http . #build image
  EOH
end


# Install mysql image
script 'Install mysql image' do
  interpreter 'bash'
  group 'root'
  user 'root'
  cwd '/home/ubuntu/dockerbuilds/mysql/'
  code <<-EOH
    set -e
    docker build -t my_mysql . #build image
  EOH
end
