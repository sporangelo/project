# Create all dirs and copy all files
include_recipe 'docker::configure'
# Install Docker
include_recipe 'docker::install'
# Start dockers mysql and http
include_recipe 'docker::services'
# Set up cron scripts
include_recipe 'docker::crontab'
