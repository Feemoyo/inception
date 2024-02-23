FROM debian:oldstable

WORKDIR	/var/www/html/

RUN apt update -y

RUN apt upgrade -y

RUN apt install -y \
	php-fpm \
	php-mysql \
	mariadb-client -y \
	wget

RUN sed -i.default "/^listen\s=.*/c\listen = 0.0.0.0:9000" \
	/etc/php/[0-9]*.[0-9]*/fpm/pool.d/www.conf

RUN wget https://wordpress.org/latest.tar.gz && \
	tar -xzf latest.tar.gz && \
	mv wordpress/* . && \
	rm -rf wordpress && \
	rm -rf latest.tar.gz

RUN cp wp-config-sample.php wp-config.php && \
	
