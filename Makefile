DATA_DIR = /home/moait-la/data
DATABASE_DIR = $(DATA_DIR)/mariadb
WORDPRESS_DIR = $(DATA_DIR)/wordpress
COMPOSE_FILE_PATH = ./srcs/docker-compose.yml

GREEN  = \033[0;32m
YELLOW = \033[0;33m
BLUE   = \033[0;34m
RESET  = \033[0m

all: build up

$(DATA_DIR):
	@echo "$(BLUE)Creating data directories$(RESET)"
	@mkdir -p $(DATABASE_DIR) $(WORDPRESS_DIR)

build: $(DATA_DIR)
	@echo "$(GREEN)Building docker images$(RESET)"
	@docker compose -f $(COMPOSE_FILE_PATH) build

up:
	@echo "$(GREEN)Starting containers$(RESET)"
	@docker compose -f $(COMPOSE_FILE_PATH) up -d

down:
	@echo "$(YELLOW)Stopping and removing containers$(RESET)"
	@docker compose -f $(COMPOSE_FILE_PATH) down

stop:
	@echo "$(YELLOW)Stopping containers$(RESET)"
	@docker compose -f $(COMPOSE_FILE_PATH) stop

start:
	@echo "$(GREEN)Starting containers$(RESET)"
	@docker compose -f $(COMPOSE_FILE_PATH) start

logs:
	@docker compose -f $(COMPOSE_FILE_PATH) logs -f

clean: down
	@echo "$(GREEN)Removing all containers$(RESET)"

fclean: clean
	@echo "$(YELLOW)Removing images, volumes and data$(RESET)"
	@docker compose -f $(COMPOSE_FILE_PATH) down -v --rmi all
	@rm -rf $(DATA_DIR)

status:
	@echo "$(GREEN)up containers status$(RESET)"
	@docker ps

re: fclean all
	@echo "$(GREEN)Rebuild complete$(RESET)"

.PHONY: all up down stop start logs status


