FROM ubuntu:14.04

RUN apt-get update

# Install apache2
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q apache2

# Configure apache
ADD apache2.conf /etc/apache2/apache2.conf
RUN chmod 644 /etc/apache2/apache2.conf
RUN chown root:root /etc/apache2/apache2.conf

# Set password file for apache
ADD .htpasswd /etc/apache2/
RUN chmod 400 /etc/apache2/.htpasswd
RUN chown www-data:www-data /etc/apache2/.htpasswd

# Set and run docker-start.sh script
ADD docker-start-http.sh /etc/init.d/
RUN chmod +x /etc/init.d/docker-start-http.sh
#ENTRYPOINT service apache2 restart && bash
CMD ["/etc/init.d/docker-start-http.sh"]

# Copy logs.sh to image
ADD logs.sh /etc/init.d/
RUN chmod +x /etc/init.d/logs.sh

# Create cronjob for logs
RUN echo "10 9 * * * root /etc/init.d/logs.sh" >> /etc/crontab
