# Copy configs from S3
script 'Prepararation for docker' do
  interpreter 'bash'
  group 'root'
  user 'root'
  cwd '/home/ubuntu/'
  code <<-EOH
    set -e
    # Set UTC time
    timedatectl set-timezone UTC

    # Update apt sources
    apt-get update
    apt-get install -y apt-transport-https ca-certificates linux-image-extra-$(uname -r) linux-image-generic-lts-trusty
    apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
    echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" > /etc/apt/sources.list.d/docker.list
    apt-get update

    # Purge the old repo if it exists
    apt-get purge lxc-docker

    # Adjust memory and swap accounting
    sed 's/GRUB_CMDLINE_LINUX=.*/GRUB_CMDLINE_LINUX="cgroup_enable=memory swapaccount=1"/' /etc/default/grub
    echo "ubuntu ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
    #reboot
  EOH
end
