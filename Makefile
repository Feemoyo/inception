ALLPS		:= $(shell docker ps -a -q)
ALLIMG		:= $(shell docker images -q)
ALLVOL		:= $(shell docker volume ls -q)

LOGIN		= fmoreira
DATA		= data
MARIADB		= mariadb
WPRESS		= wordpress

PWD_AUX		:= $(PWD)
MARIA_P		= ./srcs/requirements/mariadb
WPRESS_P	= ./srcs/requirements/wordpress

NETWORK	= inception-network

all: network volumes images containers 
	@echo "Hello, Inception"
	${ALLPS}

network:
	docker network create ${NETWORK}

volumes:
	mkdir -p ../${LOGIN}/${DATA}/${MARIADB}
	mkdir -p ../${LOGIN}/${DATA}/${WPRESS}
	docker volume create --opt o=bind --opt type=none \
		--opt device=${PWD_AUX}/../${LOGIN}/${DATA}/${MARIADB} \
		${MARIADB}-volume
	docker volume create --opt o=bind --opt type=none \
	--opt device=${PWD_AUX}/../${LOGIN}/${DATA}/${WPRESS} \
		${WPRESS}-volume

images:
	docker build --tag ${MARIADB}_image ${MARIA_P}
	docker build --tag ${WPRESS}_image ${WPRESS_P}

containers:
	docker run -d --network ${NETWORK} --network-alias ${MARIADB} \
		--mount source=${MARIADB}-volume,target=/var/lib/mysql \
		${MARIADB}_image
	docker run -d --network ${NETWORK} --network-alias ${WPRESS} \
                --mount source=${WPRESS}-volume,target=/var/lib/mysql \
                ${WPRESS}_image

stop:
	docker stop ${ALLPS}

start:
	docker start ${ALLPS}

rmall:
	docker rm ${ALLPS}

rmiall:
	docker rmi ${ALLIMG}

rmvall:
	docker volume rm ${ALLVOL}

fclean: stop rmall rmiall rmvall
	sudo rm -rf $(pwd)/../${LOGIN}
	docker network rm ${NETWORK}

re: fclean all

.PHONY: stop rmall rmiall rmvall
