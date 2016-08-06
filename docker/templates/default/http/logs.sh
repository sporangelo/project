# Collect logs and upload to S3 bucket
# Bucket name: project-cosmin
# Folders under the bucket: logs, http

#!/bin/bash
export AWS_ACCESS_KEY_ID=AKIAJFGN2ZQPYEBBZQTQ
export AWS_SECRET_ACCESS_KEY=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
export REGION=us-east-1

# Copy all logs:
mkdir -p /var/tmp/http_logs
docker cp http:/var/log/apache2/. /var/tmp/http_logs

# Upload to S3 and clean local files
aws s3 sync /var/tmp/http_logs/. s3://project-cosmin/logs/http/ && rm -f rm -rdf /var/tmp/http_logs
