#!/bin/sh

# gdrive backup
[ ! -d "/root/.duply/tree" ] && duply tree create
cp /app/duply/conf.cache /root/.duply/tree/conf.cache
envsubst < /app/duply/conf > /root/.duply/tree/conf
envsubst < /app/duply/gdrive > /root/.duply/tree/gdrive
echo "0 2 * * * duply tree backup" | crontab -

# webtrees themes
cp -r /app/webtrees/modules_v4/* /var/www/html/modules_v4/

# apache2 .htaccess
cp /app/apache2/.htaccess /var/www/html/

# start apache2
service apache2 start

# sleep
sleep infinity
