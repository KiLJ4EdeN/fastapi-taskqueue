RED=\033[0;31m
GREEN=\033[0;32m
YELLOW=\033[1;33m
BLUE=\033[0;34m
CYAN=\033[0;36m
NC=\033[0m

help:  ## 💬 This help message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

install: ## 👀 Install project dependencies
	@poetry install

build: ## 👀 Build the package dist, /dist folder
	@poetry build

bump-major: ## 📜 Bump major version
	@poetry version major

bump-minor: ## 📜 Bump minor version
	@poetry version minor

bump-patch: ## 📜 Bump patch version
	@poetry version patch

bump-prerelease: ## 📜 Bump prerelease version
	@poetry version prerelease

pre-commit: ## 🔎 Run pre-commit hooks
	@poetry run pre-commit run --all-files

flake-lint-test: ## 👀 Lint code via flake8
	@poetry run flake8 object_storage/ tests/

black-lint-test: ## 👀 Check code format via black
	@poetry run black object_storage/ tests/ --check

black-lint-fix: ## 🧼 Format code via black
	@poetry run black object_storage/ tests/ --config pyproject.toml

mypy-lint: ## 👀 Check code typing with mypy (optional)
	@poetry run mypy object_storage/ tests/

create-nginx: ## 📜 Create and update nginx config based on .env
	.scripts/nginx_gen.sh

test: ## 🎯 Unit tests
	@poetry run pytest

create-cov-dir: ## 📊 Create Coverage directory
	@poetry run coverage run -m pytest -s --disable-pytest-warnings tests/test_version.py && poetry run coverage html

cover-test: ## 📊 Unit tests with HTML report
	@make create-cov-dir && poetry run coverage run -m pytest -s --disable-pytest-warnings && poetry run coverage html

create-doc: ## 📜 Generate Documentation using mkdocs
	@poetry run mkdocs build

host-doc: ## 📜 Host Documentation on local machine
	@poetry run mkdocs serve -a 0.0.0.0:9191

docker-build: ## 🧼 Build docker compose
	docker compose build

docker-up: ## 🧼 Start the service using docker
	docker compose up

docker-down: ## 🧼 Stop the service using docker
	docker compose down

clean:  ## 🧹 Clean up project
	.scripts/clean.sh

.PHONY: install build clean
