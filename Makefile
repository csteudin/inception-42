#__INCEPTION_MAKEFILE__#

#colors
RED = \033[0;31m
GREEN = \033[0;32m
BLUE = \033[0;34m
RESET = \033[0m

#defines
PROJECT = inception
SRC_DIR = srcs
DOC_COMPOSE = $(SRC_DIR)/docker-compose.yml

#modifications
.PHONY: build up down clean
.SILENT:

#commands
all: build up

build:
	echo "$(BLUE)building $(PROJECT)...$(RESET)"
	docker-compose -f $(DOC_COMPOSE) build && \
	echo "$(GREEN) $(PROJECT) succesfully built!$(RESET)" || \
	echo "$(RED) $(PROJECT) failed the building process!$(RESET)"

# for single testing !/-._.-\!
up:
	echo "$(BLUE)starting $(PROJECT)...$(RESET)"
	docker-compose -f $(DOC_COMPOSE) up -d

db:
	echo "$(BLUE)starting mariadb...$(RESET)"
	docker-compose -f $(DOC_COMPOSE) up -d mariadb

wp:
	echo "$(BLUE)starting wordpress...$(RESET)"
	docker-compose -f $(DOC_COMPOSE) up -d wordpress

nx:
	echo "$(BLUE)starting nginx...$(RESET)"
	docker-compose -f $(DOC_COMPOSE) up -d nginx

down:
	echo "$(BLUE)stopping $(PROJECT)...$(RESET)"
	docker-compose -f $(DOC_COMPOSE) down

clean: down
	echo "$(BLUE)removing everything...$(RESET)"
	docker system prune -af
	docker volume prune -f
	docker network prune -f

re: clean build up

secrets: 
	mkdir -p ./secrets
	touch secrets/db_passwd
	touch secrets/db_root_passwd
	touch secrets/wp_passwd
	touch secrets/wp_root_passwd

