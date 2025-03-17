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

up:
	echo "$(BLUE)starting $(PROJECT)...$(RESET)"
	docker-compose -f $(DOC_COMPOSE) up -d

down:
	echo "$(BLUE)stopping $(PROJECT)...$(RESET)"
	docker-compose -f $(DOC_COMPOSE) down

clean: down
	echo "$(BLUE)removing everything...$(RESET)"
	docker system prune -af
	docker volume prune -f
	docker network prune -f