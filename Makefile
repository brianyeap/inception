COMPOSE = docker compose -f ./srcs/docker-compose.yml
DATA_DIR = /home/bryeap/data
MYSQL_DIR = $(DATA_DIR)/mysql
WP_DIR = $(DATA_DIR)/wordpress

.PHONY: all re down clean fclean prepare

prepare:
	@mkdir -p $(MYSQL_DIR) $(WP_DIR)

all: prepare
	@$(COMPOSE) up -d --build

down:
	@$(COMPOSE) down

re:
	@$(COMPOSE) up -d --build

clean:
	@$(COMPOSE) down --remove-orphans

fclean:
	@$(COMPOSE) down -v --remove-orphans
