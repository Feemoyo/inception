FROM	debian:oldstable

ARG	WP_DB
ARG	WP_USER
ARG	WP_PASSWORD

RUN apt update -y
RUN apt upgrade -y
RUN apt install mariadb-server -y

RUN echo "[mysqld] \n\
	skip-networking=0 \n\
	skip-bind-address" >> /etc/mysql/my.cnf

RUN service mariadb start && \
	mariadb -u root -e \
	"CREATE DATABASE IF NOT EXISTS $WP_DB; \
	CREATE USER '$WP_USER'@'%' identified by '$WP_PASSWORD'; \
	GRANT ALL ON $WP_DB.* TO '$WP_USER'@'%' IDENTIFIED BY '$WP_PASSWORD'; \
	FLUSH PRIVILEGES;" && \
	service mariadb stop

CMD ["mysqld_safe"]
