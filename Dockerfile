FROM phusion/baseimage
LABEL Rob Mellett <robmellett@gmail.com>

# Environmental Configuration
ENV XDEBUG_HOST=${XDEBUG_HOST}

# Ensure UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# Use UTC Time
# RUN ln -sf /usr/share/zoneinfo/UTC /etc/localtime

# Set Timezone to Melbourne, Australia
RUN ln -sf /usr/share/zoneinfo/Australia/Melbourne /etc/localtime

# Install Recommended Packages
RUN apt update \
    && apt -q -y install curl wget zip unzip git python2.7 unattended-upgrades htop lnav

# Install Nginx
RUN apt update \
    && apt -q -y install software-properties-common \
    && apt-add-repository ppa:nginx/development \
    && apt -q -y update \
    && apt -q -y install nginx

ADD nginx/nginx.conf /etc/nginx/nginx.conf
ADD nginx/default.conf /etc/nginx/sites-enabled/default

# PHP
RUN add-apt-repository ppa:ondrej/php && apt update
RUN apt -q -y install \
    php7.2 \
    php7.2-fpm \
    php7.2-common \ 
    php7.2-cli \
    php7.2-mbstring \
    php7.2-xml \
    php7.2-curl \
    php7.2-gd \
    php7.2-dev \
    php7.2-xml \
    php7.2-bcmath \
    php7.2-mysql \
    php7.2-mbstring \
    php7.2-zip \
    php7.2-sqlite \
    php7.2-soap \
    php7.2-json \
    php7.2-intl \
    php7.2-imap \
    php-mysql \
    php-curl \
    php-zip \
    php-xdebug \
    php-memcached
RUN command -v php

COPY ./php/php.ini /etc/php/7.2/cli/php.ini
COPY ./php/xdebug.ini /etc/php/7.2/mods-available/xdebug.ini

# Install Composer
RUN php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer

# Install Redis
RUN apt-add-repository -y ppa:chris-lea/redis-server && apt update
RUN apt -q -y install redis-server

# Node
RUN curl --silent --location https://deb.nodesource.com/setup_9.x | bash - && apt update
RUN apt -q -y install nodejs

# Expose the Nginx Log to Docker
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

# Yarn
RUN curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt -q -y update && apt -q -y install yarn

# Prometheus Monitoring
RUN curl https://s3-eu-west-1.amazonaws.com/deb.robustperception.io/41EFC99D.gpg | apt-key add -
RUN apt update && apt -q -y prometheus-node-exporter

# Copy Start Service Scripts
RUN mkdir -p /etc/my_init.d
COPY ./services/setup.sh /etc/my_init.d
RUN chmod +x /etc/my_init.d/setup.sh

# Use baseimage-docker's init system.
# https://github.com/phusion/baseimage-docker
CMD ["/sbin/my_init"]

# Clean up APT when done to minimise filesize.
RUN apt -q -y clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /var/www/html

EXPOSE 80 443