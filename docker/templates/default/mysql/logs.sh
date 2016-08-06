# Collect logs and upload to S3 bucket
# Bucket name: project-cosmin
# Folders under the bucket: logs/mysql

#!/bin/bash
export AWS_ACCESS_KEY_ID=AKIAJFGN2ZQPYEBBZQTQ
export AWS_SECRET_ACCESS_KEY=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
export REGION=us-east-1

# Copy all logs:
mkdir -p /var/tmp/mysql_logs
docker cp mysql:/var/log/mysql/. /var/tmp/mysql_logs

# Upload to S3
aws s3 sync /var/tmp/mysql_logs/. s3://project-cosmin/logs/mysql/ && rm -rdf /var/tmp/mysql_logs
