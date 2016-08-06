# Backup mysql and http to S3 bucket
# Bucket name: project-cosmin
# Folders under the bucket: backups/http_dumps backups/mysql_dumps

#!/bin/bash
export AWS_ACCESS_KEY_ID=AKIAJFGN2ZQPYEBBZQTQ
export AWS_SECRET_ACCESS_KEY=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
export REGION=us-east-1

# Backup mysql dump
MYSQL_ROOT_PASSWORD="root"
CONTAINER_NAME="my_mysql"
CONTAINER_ID=$(docker ps | grep $CONTAINER_NAME | awk '{print $1}')
DATE_FILE=$(date '+%Y-%m-%d')

# Crate new sqldump file
docker exec -it $CONTAINER_ID script /dev/null -c "rm -f /var/lib/mysql/db_backup.sql; /usr/bin/mysqldump -uroot -p$MYSQL_ROOT_PASSWORD --all-databases > /var/lib/mysql/db_backup.sql"
# Copy file to host
docker cp mysql:/var/lib/mysql/db_backup.sql /var/tmp/$DATE_FILE-backup.sql
# Upload file to S3
aws s3 cp --region=us-east-1 /var/tmp/$DATE_FILE-backup.sql s3://project-cosmin/backups/mysql_dumps/$DATE_FILE-backup.sql

# Backup http site
CONTAINER_NAME="my_http"
CONTAINER_ID=$(docker ps | grep $CONTAINER_NAME | awk '{print $1}')
DATE_FILE=$(date '+%Y-%m-%d')
# Crate new site archive
docker exec -it $CONTAINER_ID script /dev/null -c "rm -f /var/www/html.tar.gz; tar -zcvf /var/www/html.tar.gz html"
# Copy file to host
docker cp http:/var/www/html.tar.gz /var/tmp/$DATE_FILE-backup.http
# Upload file to S3
aws s3 cp --region=us-east-1 /var/tmp/$DATE_FILE-backup.http s3://project-cosmin/backups/http_dumps/$DATE_FILE-backup.http

# Clean local files
rm -f /var/tmp/$DATE_FILE-backup.sql
rm -f /var/tmp/$DATE_FILE-backup.http
