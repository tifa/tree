.DEFAULT_GOAL := start

ACTIVATE = . venv/bin/activate;
ASSETS = $(shell find assets -type f -name '*')
PROJECT_NAME = tree

define usage
@printf "Usage: make target\n\n"
@printf "$(FORMAT_UNDERLINE)target$(FORMAT_END):\n"
@grep -E "^[A-Za-z0-9_ -]*:.*#" $< | while read -r l; do printf "  $(FORMAT_BOLD_YELLOW)%-$(COL_WIDTH)s$(FORMAT_END)$$(echo $$l | cut -f2- -d'#')\n" $$(echo $$l | cut -f1 -d':'); done
endef

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
	@MYSQL_ROOT_PASSWORD=$(shell aws ssm get-parameter --name /app/tree/mysql_root_password --with-decryption --query "Parameter.Value" --output text) \
	MYSQL_PASSWORD=$(shell aws ssm get-parameter --name /app/tree/mysql_password --with-decryption --query "Parameter.Value" --output text) \
		docker compose up --detach

.PHONY: restart
restart: stop start  # Restart service

.PHONY: stop
stop:  # Stop service
	docker compose down --remove-orphans

.PHONY: sh
sh bash:  # Bash into webtrees container
	@docker exec -it $$(docker ps -asf "name=$(PROJECT_NAME)" | grep -v CONTAINER | cut -d' ' -f1) bash

.PHONY: mysql
mysql:  # Bash into mysql container
	@docker exec -it $$(docker ps -asf "name=mysql" | grep -v CONTAINER | cut -d' ' -f1) bash

.PHONY: check
check: venv  # Run pre-commit hooks
	@$(ACTIVATE) pre-commit run --all