#!/bin/sh

set -e

# Override XDebug variables from docker-compose.yml
echo "\n"
echo ">>> Configuring XDebug Settings."
sed -i "s/xdebug\.remote_enable\=.*/xdebug\.remote_enable\="$XDEBUG_REMOTE_ENABLE"/g" /etc/php/7.2/mods-available/xdebug.ini
sed -i "s/xdebug\.remote_autostart\=.*/xdebug\.remote_autostart\="$XDEBUG_REMOTE_AUTOSTART"/g" /etc/php/7.2/mods-available/xdebug.ini
sed -i "s/xdebug\.remote_connect_back\=.*/xdebug\.remote_connect_back\="$XDEBUG_REMOTE_CONNECT_BACK"/g" /etc/php/7.2/mods-available/xdebug.ini
sed -i "s/xdebug\.remote_host\=.*/xdebug\.remote_host\="$XDEBUG_HOST"/g" /etc/php/7.2/mods-available/xdebug.ini
sed -i "s/xdebug\.remote_port\=.*/xdebug\.remote_port\="$XDEBUG_REMOTE_PORT"/g" /etc/php/7.2/mods-available/xdebug.ini
sed -i "s/xdebug\.idekey\=.*/xdebug\.idekey\="$XDEBUG_IDEKEY"/g" /etc/php/7.2/mods-available/xdebug.ini

echo "\n"
cat /etc/php/7.2/mods-available/xdebug.ini
echo "\n"