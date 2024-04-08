COMPOSE_FILE=./srcs/docker-compose.yml
DB_VOLUME_DIR= /home/login/data/mariadb
WP_VOLUME_DIR= /home/login/data/wordpress

all: up

up: mk_vols
	docker-compose -f ${COMPOSE_FILE} up --build

build: mk_vols
	docker-compose -f ${COMPOSE_FILE} build --no-cache

mk_vols:
	mkdir -p ${DB_VOLUME_DIR}
	mkdir -p ${WP_VOLUME_DIR}

down:
	docker-compose -f ${COMPOSE_FILE} down

clean:
	docker-compose -f ${COMPOSE_FILE} rm -s -f

fclean: down
	docker-compose -f ${COMPOSE_FILE} rm -s -v -f

.PHONY: all build clean down fclean mk_vols up
