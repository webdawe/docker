FROM robmellett/base:latest
LABEL Rob Mellett <robmellett@gmail.com>

# Install Recommended Packages
RUN apt-get update \
  && apt-get -q -y install supervisor

# Supervisor
COPY supervisor/supervisord.conf /etc/supervisor/supervisord.conf
COPY supervisor/conf.d/*.conf /etc/supervisor/conf.d-available/

# Confd
COPY ./confd/templates /etc/confd/templates
COPY ./confd/conf.d /etc/confd/conf.d

# Install Nginx
RUN apt-get update \
  && apt-get -q -y install software-properties-common \
  && apt-add-repository ppa:nginx/development \
  && apt-get -q -y update \
  && apt-get -q -y install nginx-full

ADD nginx/nginx.conf /etc/nginx/nginx.conf
ADD nginx/default-node.conf /etc/nginx/sites-available/default
ADD nginx/self-signed.conf /etc/nginx/snippets/self-signed.conf
ADD nginx/ssl-params.conf /etc/nginx/snippets/ssl-params.conf

# Install PM2 for Node.js Apps
RUN npm install pm2 -g

# Copy Start Service Scripts
RUN mkdir -p /etc/my_init.d
COPY ./services/setup-node.sh /etc/my_init.d/setup
COPY ./ssl/ssl.sh /etc/my_init.d/ssl.sh

RUN chmod +x \
  /etc/my_init.d/setup \
  /usr/local/bin/confd \
  /etc/my_init.d/ssl.sh

# Create SSL Certs
RUN /etc/my_init.d/ssl.sh

RUN chown -R ubuntu:www-data /var/www/html

# Expose the Logs to Docker
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
  && ln -sf /dev/stderr /var/log/nginx/error.log

# Use baseimage-docker's init system.
# https://github.com/phusion/baseimage-docker
CMD ["/sbin/my_init"]

# Clean up APT when done to minimise filesize.
RUN apt-get -q -y clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set working directory to the project
WORKDIR /var/www/html

# Expose Ports for Web/HTTPS
EXPOSE 80 443