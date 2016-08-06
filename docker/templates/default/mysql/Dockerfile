FROM ubuntu:14.04

RUN apt-get update

# Install mysql 5.6
RUN apt-get install -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q mysql-server-5.6

# Replace mysql conf
ADD my.cnf /etc/mysql/my.cnf
RUN chmod 644 /etc/mysql/my.cnf
RUN chown root:root /etc/mysql/my.cnf

# Set and run docker-start-mysql.sh script
ADD docker-start-mysql.sh /etc/init.d/
RUN chmod +x /etc/init.d/docker-start-mysql.sh
CMD ["/etc/init.d/docker-start-mysql.sh"]

# Copy logs.sh to image
ADD logs.sh /etc/init.d/
RUN chmod +x /etc/init.d/logs.sh

# Create cronjob for logs
RUN echo "10 9 * * * root /etc/init.d/logs.sh" >> /etc/crontab
