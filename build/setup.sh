#!/bin/sh

chown -R www-data:www-data /var/www
chmod 755 /var/www

# enable xdebug
echo 'xdebug.remote_enable=1' >> /etc/php/7.2/mods-available/xdebug.ini
echo 'xdebug.remote_connect_back=1' >> /etc/php/7.2/mods-available/xdebug.ini
echo 'xdebug.show_error_trace=1' >> /etc/php/7.2/mods-available/xdebug.ini
echo 'xdebug.remote_port=9000' >> /etc/php/7.2/mods-available/xdebug.ini
echo 'xdebug.scream=0' >> /etc/php/7.2/mods-available/xdebug.ini
echo 'xdebug.show_local_vars=1' >> /etc/php/7.2/mods-available/xdebug.ini
echo 'xdebug.idekey=VSCODE' >> /etc/php/7.2/mods-available/xdebug.ini