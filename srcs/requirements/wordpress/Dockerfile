FROM debian:oldstable

ARG	WP_DB
ARG	WP_USER
ARG	WP_PASSWORD

WORKDIR	/var/www/html/

RUN	apt update -y

RUN	apt upgrade -y

RUN	apt install -y \
	php-fpm \
	php-mysql \
	mariadb-client -y \
	wget

RUN	sed -i.default "/^listen\s=.*/c\listen = 0.0.0.0:9000" \
	/etc/php/[0-9]*.[0-9]*/fpm/pool.d/www.conf

RUN	wget https://wordpress.org/latest.tar.gz && \
	tar -xzf latest.tar.gz && \
	mv wordpress/* . && \
	rm -rf wordpress && \
	rm -rf latest.tar.gz

RUN	cp wp-config-sample.php wp-config.php && \
	sed -i "s/database_name_here/$WP_DB/g" wp-config.php && \
	sed -i "s/username_here/$WP_USER/g" wp-config.php && \
	sed -i "s/password_here/$WP_PASSWORD/g" wp-config.php && \
	sed -i "s/localhost/mariadb/g" wp-config.php

RUN	mkdir -p /run/php

RUN	ln -s $(find /usr/sbin -name 'php-fpm*') /usr/bin/php-fpm

CMD	["php-fpm", "-F"]
