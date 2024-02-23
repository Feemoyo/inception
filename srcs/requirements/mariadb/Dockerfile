FROM debian:oldstable

RUN apt update -y
RUN apt upgrade -y
RUN apt install mariadb-server -y

RUN echo "[mysqld] \n\
skip-networking=0 \n\
skip-bind-address" >> /etc/mysql/my.cnf

RUN service mariadb start && \
mariadb -u root -e \
"CREATE DATABASE IF NOT EXISTS wordpress_db; \
CREATE USER 'wuser'@'%' identified by 'wpass'; \
FLUSH PRIVILEGES;" && \
service mariadb stop

CMD ["mysqld_safe"]
