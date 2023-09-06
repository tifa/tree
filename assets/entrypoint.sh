#!/bin/sh

# webtrees themes
cp -r /app/webtrees/modules_v4/* /var/www/html/modules_v4/

# apache2 .htaccess
cp /app/apache2/.htaccess /var/www/html/

# start apache2
service apache2 start

# sleep
sleep infinity
