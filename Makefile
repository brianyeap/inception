COMPOSE = docker compose -f ./srcs/docker-compose.yml

all:
	@$(COMPOSE) up -d --build

down:
	@$(COMPOSE) down

re:
	@$(COMPOSE) up -d --build

clean:
	@$(COMPOSE) down --remove-orphans

fclean:
	@$(COMPOSE) down -v --remove-orphans

.PHONY: all re down clean fclean