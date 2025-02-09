#!/bin/sh
set -e

# webtrees themes
cp -r /app/webtrees/modules_v4/* /var/www/html/modules_v4/

# webtrees config
envsubst < /app/webtrees/data/config.ini.php > /var/www/html/data/config.ini.php

# apache2
cp /app/apache2/.htaccess /var/www/html/
a2enmod ssl
service apache2 start

# sleep
sleep infinity
