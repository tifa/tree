.DEFAULT_GOAL := start

ACTIVATE = . venv/bin/activate;
ASSETS = $(shell find assets -type f -name '*')
PROJECT_NAME = tree

COL_WIDTH = 10
FORMAT_YELLOW = 33
FORMAT_BOLD_YELLOW = \e[1;$(FORMAT_YELLOW)m
FORMAT_END = \e[0m
FORMAT_UNDERLINE = \e[4m

define usage
	@printf "Usage: make target\n\n"
	@printf "$(FORMAT_UNDERLINE)target$(FORMAT_END):\n"
	@grep -E "^[A-Za-z0-9_ -]*:.*#" $< | while read -r l; do printf "  $(FORMAT_BOLD_YELLOW)%-$(COL_WIDTH)s$(FORMAT_END)$$(echo $$l | cut -f2- -d'#')\n" $$(echo $$l | cut -f1 -d':'); done
endef

include .env

exec = @docker exec -it $$(docker ps -asf "name=$(1)" | grep -v CONTAINER | cut -d' ' -f1) bash -c "$(2)"

.git/hooks/pre-commit:
	$(ACTIVATE) pre-commit install
	@touch $@

venv: venv/.touchfile .git/hooks/pre-commit
venv/.touchfile: requirements.txt
	test -d venv || virtualenv venv
	$(ACTIVATE) pip install -Ur requirements.txt
	@touch $@

.PHONY: help
help: Makefile  # Print this message
	$(call usage)

build: venv venv/.build_touchfile  # Build image
venv/.build_touchfile: Dockerfile $(ASSETS)
	docker build -t $(PROJECT_NAME) .
	@touch $@

.PHONY: start
start: build  # Start service
	@docker compose --project-name $(PROJECT_NAME) up --detach

.PHONY: restart
restart: stop start  # Restart service

.PHONY: stop
stop:  # Stop service
	@docker compose down --remove-orphans

.PHONY: down
down:  # Maintenance mode
	$(call exec,$(PROJECT_NAME),touch /var/www/html/data/offline.txt)

.PHONY: up
up:  # Online mode
	$(call exec,$(PROJECT_NAME),rm -f /var/www/html/data/offline.txt)

.PHONY: sh
sh bash:  # Bash into webtrees container
	$(call exec,$(PROJECT_NAME),bash)

.PHONY: mysql
mysql:  # Bash into mysql container
	$(call exec,mysql,bash)

.PHONY: check
check: venv  # Run pre-commit hooks
	@$(ACTIVATE) pre-commit run --all

.PHONY: clean
clean: stop  # Clean all files
	@git clean -xdf -e .env

.PHONY: open
open:  # Open webtrees
	open https://$(HOSTNAME)

.PHONY: backup
backup:  # Back up data
	$(call exec,$(PROJECT_NAME),MYSQL_PWD=$(MYSQL_PASSWORD) mysqldump -h mysql -u root $(MYSQL_DATABASE) > /backup/mysql/webtrees.sql)
	@zip -r ./backup/tree.zip ./backup
