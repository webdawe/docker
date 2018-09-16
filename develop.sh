#!/bin/bash

export APP_PORT=${APP_PORT:-80}
export DB_PORT=${DB_PORT:-3306}
export XDEBUG_HOST=${XDEBUG_HOST:-192.168.0.6}

if [ $# -gt 0 ];then
    docker-compose "$@"
else
    docker-compose ps
fi