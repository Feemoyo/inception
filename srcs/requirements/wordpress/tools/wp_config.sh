#!/bin/sh

chown -R www-data:www-data /var/www/

sudo -u www-data sh -c "wp core download"
sudo -u www-data sh -c "wp config create --dbname=$WP_DB --dbuser=$WP_USER --dbpass=$WP_PASSWORD --dbhost=mariadb --dbcharset='utf8'"
sudo -u www-data sh -c "wp core install --url=$WP_URL --title=Inception --admin_user=$ADMIN_USER --admin_password=$ADMIN_PASS --admin_email=$ADMIN_MAIL --skip-email"
sudo -u www-data sh -c "wp user create $USER_USER $USER_MAIL --role=author --user_pass=$USER_PASS"
sudo -u www-data sh -c "wp plugin update --all"

ln -s $(find /usr/sbin -name 'php-fpm*') /usr/bin/php-fpm

exec /usr/bin/php-fpm -F
