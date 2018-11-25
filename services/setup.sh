#!/bin/sh

env=${APP_ENV:-production}
echo "The Environment is set to: $env"

echo "\n"
echo ">>> Configuring PHP Settings."
sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php/7.2/cli/php.ini
#sed -i "s/display_errors = .*/display_errors = On/" /etc/php/7.2/cli/php.ini
sed -i "s/memory_limit = .*/memory_limit = 512M/" /etc/php/7.2/cli/php.ini
sed -i "s/;date.timezone.*/date.timezone = UTC/" /etc/php/7.2/cli/php.ini

sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php/7.2/fpm/php.ini
sed -i "s/memory_limit = .*/memory_limit = 512M/" /etc/php/7.2/fpm/php.ini
sed -i "s/;date.timezone.*/date.timezone = UTC/" /etc/php/7.2/fpm/php.ini

sed -i "s/upload_max_filesize = .*/upload_max_filesize = 100M/" /etc/php/7.2/fpm/php.ini
sed -i "s/post_max_size = .*/post_max_size = 100M/" /etc/php/7.2/fpm/php.ini
sed -i "s/max_execution_time = .*/max_execution_time = 300/" /etc/php/7.2/fpm/php.ini

# Override XDebug variables from docker-compose.yml
echo "\n"
echo ">>> Configuring XDebug Settings."
sed -i "s/xdebug\.remote_enable\=.*/xdebug\.remote_enable\="$XDEBUG_REMOTE_ENABLE"/g" /etc/php/7.2/mods-available/xdebug.ini
sed -i "s/xdebug\.remote_autostart\=.*/xdebug\.remote_autostart\="$XDEBUG_REMOTE_AUTOSTART"/g" /etc/php/7.2/mods-available/xdebug.ini
sed -i "s/xdebug\.remote_connect_back\=.*/xdebug\.remote_connect_back\="$XDEBUG_REMOTE_CONNECT_BACK"/g" /etc/php/7.2/mods-available/xdebug.ini
sed -i "s/xdebug\.remote_host\=.*/xdebug\.remote_host\="$XDEBUG_HOST"/g" /etc/php/7.2/mods-available/xdebug.ini
sed -i "s/xdebug\.remote_port\=.*/xdebug\.remote_port\="$XDEBUG_REMOTE_PORT"/g" /etc/php/7.2/mods-available/xdebug.ini
sed -i "s/xdebug\.idekey\=.*/xdebug\.idekey\="$XDEBUG_IDEKEY"/g" /etc/php/7.2/mods-available/xdebug.ini

if [ "$env" != "local" ]; then
    echo ">>> Environment is not local, removing XDebug."
    rm -rf "/etc/php/7.2/mods-available/xdebug.ini"
fi

# Display contents of xdebug
cat "/etc/php/7.2/mods-available/xdebug.ini"

# Fix www permissions
chgrp -R www-data /var/www/html
chmod 755 /var/www/html

# Start Web Services
echo "\n"
echo ">>> Starting Web Services"
service php7.2-fpm start
nginx -g "daemon off;"