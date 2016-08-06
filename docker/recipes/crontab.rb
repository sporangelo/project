cron 'backup_cron' do
  minute '10'
  hour '9'
  user 'root'
  action :create
  command '/home/ubuntu/backup.sh'
end
