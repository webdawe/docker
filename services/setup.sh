#!/bin/sh

# Override XDebug variables from docker-compose.yml
sed -i "s/xdebug\.remote_host\=.*/xdebug\.remote_host\="$XDEBUG_HOST"/g" /etc/php/7.2/mods-available/xdebug.ini
sed -i "s/xdebug\.remote_port\=.*/xdebug\.remote_port\="$XDEBUG_REMOTE_PORT"/g" /etc/php/7.2/mods-available/xdebug.ini
sed -i "s/xdebug\.idekey\=.*/xdebug\.idekey\="$XDEBUG_IDEKEY"/g" /etc/php/7.2/mods-available/xdebug.ini

# Display contents of xdebug
cat "/etc/php/7.2/mods-available/xdebug.ini"

chown -R www-data:www-data /var/www
chmod 755 /var/www

# Start Web Services
echo "\n"
echo ">>> Starting Web Services"
service php7.2-fpm start
nginx -g "daemon off;"