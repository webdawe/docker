FROM phusion/baseimage
LABEL Rob Mellett <robmellett@gmail.com>

# Environmental Configuration
ENV XDEBUG_REMOTE_ENABLE=${XDEBUG_REMOTE_ENABLE}
ENV XDEBUG_REMOTE_AUTOSTART=${XDEBUG_REMOTE_AUTOSTART}
ENV XDEBUG_REMOTE_CONNECT_BACK=${XDEBUG_REMOTE_CONNECT_BACK}
ENV XDEBUG_HOST=${XDEBUG_HOST}
ENV XDEBUG_REMOTE_PORT=${XDEBUG_REMOTE_PORT}
ENV XDEBUG_IDEKEY=${XDEBUG_IDEKEY}

# Ensure UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# Use UTC Time
# RUN ln -sf /usr/share/zoneinfo/UTC /etc/localtime

# Set Timezone to Melbourne, Australia
RUN ln -sf /usr/share/zoneinfo/Australia/Melbourne /etc/localtime

# Install Recommended Packages
RUN apt-get update \
    && apt-get -q -y install supervisor curl wget zip unzip git sqlite3 htop lnav vim unattended-upgrades

# Prometheus Monitoring
RUN curl https://s3-eu-west-1.amazonaws.com/deb.robustperception.io/41EFC99D.gpg | apt-key add -
RUN apt-get update && apt-get -q -y install prometheus-node-exporter

# Supervisor
COPY supervisor/supervisord.conf /etc/supervisor/supervisord.conf
COPY supervisor/conf.d/*.conf /etc/supervisor/conf.d-available/

# Install Nginx
RUN apt-get update \
    && apt-get -q -y install software-properties-common \
    && apt-add-repository ppa:nginx/development \
    && apt-get -q -y update \
    && apt-get -q -y install nginx-full

ADD nginx/nginx.conf /etc/nginx/nginx.conf
ADD nginx/default.conf /etc/nginx/sites-available/default

# PHP
RUN add-apt-repository ppa:ondrej/php && apt-get update
RUN apt-get -q -y install \
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
    php7.2-pgsql \
    php-mysql \
    php-curl \
    php-zip \
    php-xdebug \
    php-memcached
RUN command -v php

COPY ./php/php.ini /etc/php/7.2/cli/php.ini
COPY ./php/xdebug.ini /etc/php/7.2/mods-available/xdebug.ini
COPY ./php/www.conf /etc/php/7.2/fpm/pool.d/www.conf
COPY ./php/php-fpm.conf /etc/php/7.2/fpm/php-fpm.conf

# Install Composer
RUN php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer

# Install Redis
# RUN apt-add-repository -y ppa:chris-lea/redis-server && apt-get update
# RUN apt-get -q -y install redis-server

# Node
RUN curl --silent --location https://deb.nodesource.com/setup_9.x | bash - && apt-get update
RUN apt-get -q -y install nodejs

# Yarn
RUN wget -qO - https://raw.githubusercontent.com/yarnpkg/releases/gh-pages/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get -q -y update && apt-get -q -y install yarn

# Confd
ADD https://github.com/kelseyhightower/confd/releases/download/v0.11.0/confd-0.11.0-linux-amd64 /usr/local/bin/confd
COPY ./confd/templates /etc/confd/templates
COPY ./confd/conf.d /etc/confd/conf.d

# Copy Start Service Scripts
RUN mkdir -p /etc/my_init.d
COPY ./services/xdebug.sh /usr/sbin/xdebug.sh
COPY ./services/php.sh /etc/my_init.d/php.sh
COPY ./services/setup.sh /etc/my_init.d/setup

RUN chmod +x \
    /etc/my_init.d/setup \
    /etc/my_init.d/php.sh \
    /usr/sbin/xdebug.sh \
    /usr/local/bin/confd

RUN chown -R www-data:www-data /var/www/html

# Expose the Logs to Docker
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log \
    && ln -sf /dev/stdout /var/log/php7.2-fpm.log

# Use baseimage-docker's init system.
# https://github.com/phusion/baseimage-docker
CMD ["/sbin/my_init"]

# Clean up APT when done to minimise filesize.
RUN apt-get -q -y clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /var/www/html

# Expose Ports for Web, Prometheus node_exporter
EXPOSE 80 443 9100
