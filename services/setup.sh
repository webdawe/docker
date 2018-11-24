#!/bin/sh

echo "\n"
echo ">>> Configuring PHP Settings."
sudo sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php/7.2/cli/php.ini
#sudo sed -i "s/display_errors = .*/display_errors = On/" /etc/php/7.2/cli/php.ini
sudo sed -i "s/memory_limit = .*/memory_limit = 512M/" /etc/php/7.2/cli/php.ini
sudo sed -i "s/;date.timezone.*/date.timezone = UTC/" /etc/php/7.2/cli/php.ini

# Set some defaults in PHP FPM
sudo sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php/7.2/fpm/php.ini
sudo sed -i "s/memory_limit = .*/memory_limit = 512M/" /etc/php/7.2/fpm/php.ini
sudo sed -i "s/;date.timezone.*/date.timezone = UTC/" /etc/php/7.2/fpm/php.ini

sudo sed -i "s/upload_max_filesize = .*/upload_max_filesize = 100M/" /etc/php/7.2/fpm/php.ini
sudo sed -i "s/post_max_size = .*/post_max_size = 100M/" /etc/php/7.2/fpm/php.ini
sudo sed -i "s/max_execution_time = .*/max_execution_time = 300/" /etc/php/7.2/fpm/php.ini

# Override XDebug variables from docker-compose.yml
echo "\n"
echo ">>> Configuring XDebug Settings."
sed -i "s/xdebug\.remote_host\=.*/xdebug\.remote_host\="$XDEBUG_HOST"/g" /etc/php/7.2/mods-available/xdebug.ini
sed -i "s/xdebug\.remote_port\=.*/xdebug\.remote_port\="$XDEBUG_REMOTE_PORT"/g" /etc/php/7.2/mods-available/xdebug.ini
sed -i "s/xdebug\.idekey\=.*/xdebug\.idekey\="$XDEBUG_IDEKEY"/g" /etc/php/7.2/mods-available/xdebug.ini

# Display contents of xdebug
cat "/etc/php/7.2/mods-available/xdebug.ini"

chown -R www-data:www-data /var/www
chmod 755 /var/www/html

# Start Web Services
echo "\n"
echo ">>> Starting Web Services"
service php7.2-fpm start
nginx -g "daemon off;"