#!/bin/sh

service php7.2-fpm start

nginx -g "daemon off;"

logger $XDEBUG_HOST

# Overide $XDEBUG_HOST value from docker-compose.yml 
sed -i "s/xdebug\.remote_host\=.*/xdebug\.remote_host\=$XDEBUG_HOST/g" /etc/php/7.2/mods-available/xdebug.ini

chown -R www-data:www-data /var/www
chmod 755 /var/www