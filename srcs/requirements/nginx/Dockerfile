FROM	debian:oldstable

RUN	apt update -y
RUN	apt upgrade -y
RUN	apt install nginx -y
RUN	apt install openssl -y

RUN	openssl req -batch -x509 -sha256 -nodes -newkey rsa:2048 -days 365 \
		-keyout /etc/ssl/private/localhost.key \
		-out /etc/ssl/certs/localhost.crt

#RUN	rm -f /etc/nginx/sites-enabled/default

COPY	./conf/https.conf /etc/nginx/conf.d

EXPOSE	443

CMD	 ["nginx", "-g", "daemon off;"]
