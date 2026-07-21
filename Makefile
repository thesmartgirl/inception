NAME = inception

COMPOSE = docker-compose -f srcs/docker-compose.yml

DATA_DIR = /home/ataan/data

all: up

dirs:
	mkdir -p $(DATA_DIR)

up: dirs
	$(COMPOSE) up -d --build

build: dirs
	$(COMPOSE) build

start:
	$(COMPOSE) start

stop:
	$(COMPOSE) stop

down:
	$(COMPOSE) down

restart: down up

logs:
	$(COMPOSE) logs -f

ps:
	$(COMPOSE) ps

clean:
	$(COMPOSE) down -v

fclean: clean
	docker image prune -f -a
	docker volume prune -f

re: fclean up

exec-nginx:
	docker exec -it nginx sh

exec-wordpress:
	docker exec -it wordpress sh

exec-mariadb:
	docker exec -it mariadb sh

.PHONY: all dirs up build start stop down restart logs ps clean fclean re
