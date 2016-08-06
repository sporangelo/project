# Install http image
script 'Install docker' do
  interpreter 'bash'
  group 'root'
  user 'root'
  cwd '/home/ubuntu/dockerbuilds/http/'
  code <<-EOH
    set -e
    docker run -itd --net=host --name http my_http #run container
  EOH
end


# Install mysql image
script 'Install docker' do
  interpreter 'bash'
  group 'root'
  user 'root'
  cwd '/home/ubuntu/dockerbuilds/mysql/'
  code <<-EOH
    set -e
    docker run -itd --name mysql my_mysql #run container
  EOH
end
