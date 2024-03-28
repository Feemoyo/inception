LOGIN		= fmoreira
DATA		= data
MARIADB		= mariadb
WPRESS		= wordpress

HOME_AUX		:= $(HOME)
ALLVOL			:= $(shell docker volume ls -q)

all: setup up

up:
	sudo docker-compose --file=./srcs/docker-compose.yml --project-name=Inception up --build -d

down:
	sudo docker-compose --file=./srcs/docker-compose.yml --project-name=Inception down

setup:
	sudo mkdir -p ${HOME}/${LOGIN}/${DATA}/${MARIADB}
	sudo mkdir -p ${HOME}/${LOGIN}/${DATA}/${WPRESS}
	sudo grep -q ${LOGIN} /etc/hosts || sudo sed -i "3i127.0.0.1\t${LOGIN}.42.fr" /etc/hosts

cleanv:
	docker volume rm ${ALLVOL}
	sudo rm -rf ${HOME}/${LOGIN}

fclean: down cleanv
	docker system prune --all --force --volumes

re: fclean all

.PHONY: all up down setup flean re
