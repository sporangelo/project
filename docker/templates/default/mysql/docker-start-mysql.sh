#!/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
#includes lsb functions
. /lib/lsb/init-functions

# Start cron for needed regular logrotate
CRON=`which cron`
log_daemon_msg "Starting ${CRON}"
$CRON &

# Start apache
service mysql start &

# Open bash
BASH=`which bash`
$BASH
