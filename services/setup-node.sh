#!/usr/bin/env bash

set -e

confd -onetime -backend env

ln -sf /etc/supervisor/conf.d-available/nginx.conf /etc/supervisor/conf.d/nginx.conf

exec supervisord -c /etc/supervisor/supervisord.conf
