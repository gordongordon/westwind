#!/bin/bash

sed -i -e "s/\$INSERT_PORT/$PORT/g" /etc/nginx/nginx.conf

exec supervisord -c /etc/supervisor/conf.d/supervisord.conf
