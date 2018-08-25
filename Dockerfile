FROM phusion/baseimage
LABEL Rob Mellett <robmellett@gmail.com>

# ensure UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# Install Nginx
RUN apt-get update \
    && apt-get install -y software-properties-common \
    && apt-add-repository -y ppa:nginx/stable \
    && apt-get update \
    && apt-get install -y nginx

ADD nginx/nginx.conf /etc/nginx/nginx.conf
ADD nginx/default.conf /etc/nginx/sites-enabled/default

# PHP
RUN add-apt-repository ppa:ondrej/php && apt-get update
RUN apt-get install -y \
    php7.2 \
    php7.2-fpm \
    php7.2-common \ 
    php7.2-cli \
    php-mysql \
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
    php-curl \
    php-zip \
    php-xdebug \
    php-memcached
RUN command -v php

# Expose the Nginx Log to Docker
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

# Copy Start Service Scripts
RUN mkdir -p /etc/my_init.d
COPY ./build/ /etc/my_init.d
RUN chmod +x /etc/my_init.d/*.sh

# Use baseimage-docker's init system.
# https://github.com/phusion/baseimage-docker
CMD ["/sbin/my_init"]

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 80 443