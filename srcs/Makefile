COMPOSE_FILE = ./srcs/docker-compose.yml
DATA_DIR = /home/moait-la/data
DATABASE_DIR = ${DATA_DIR}/mariadb
WORDPRESS_DIR = ${DATA_DIR}/wordpress 

GREEN = \033[0;32m
YELLOW = \033[0;33m
BLUE = \033[0;34m
RED = \033[0;31m
RESET = \033[0m

all: build up

${DATA_DIR}:
	@echo "$(BLUE)[+] Creating data directories...$(RESET)"
	@mkdir -p ${DATABASE_DIR} ${WORDPRESS_DIR}

build: ${DATA_DIR}
	@echo "$(GREEN)[+] Building docker images...$(RESET)"
	@docker compose build

up:
	@echo "$(GREEN)[+] Starting containers...$(RESET)"
	@docker compose up

down:
	@echo "$(YELLOW)[!] Stopping and removing containers...$(RESET)"
	@docker compose down

stop:
	@echo "$(YELLOW)[!] Stopping containers (keeping them)...$(RESET)"
	@docker compose stop

start:
	@echo "$(GREEN)[+] Starting stopped containers...$(RESET)"
	@docker compose start

logs:
	@echo "$(BLUE)[*] Showing container logs...$(RESET)"
	@docker compose logs -f

clean: down
	@echo "$(RED)[!] Removing containers...$(RESET)"

fclean: clean
	@echo "$(RED)[!] Removing images, volumes and data...$(RESET)"
	@docker compose down -v --rmi all
	@rm -rf ${DATA_DIR}

re: fclean all
	@echo "$(GREEN)[+] Rebuild complete.$(RESET)"

.PHONY: logs start stop down up build clean fclean re
