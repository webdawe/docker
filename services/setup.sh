#!/bin/sh

service php7.2-fpm start

nginx -g "daemon off;"

chown -R www-data:www-data /var/www
chmod 755 /var/www