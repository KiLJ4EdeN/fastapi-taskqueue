install:
	poetry install
build:
	poetry build
bump-major:
	poetry version major
bump-minor:
	poetry version minor
bump-patch:
	poetry version patch
bump-prerelease:
	poetry version prerelease
pre-commit:
	poetry run pre-commit run --all-files
fmt-black:
	poetry run black python_template/ tests/
lint-black:
	poetry run black --check python_template/ tests/
lint-flake8:
	poetry run flake8 python_template/ tests/
lint-mypy:
	poetry run mypy python_template/ tests/
lint: lint-black lint-flake8 lint-mypy
cleanup:
	.scripts/clean.sh
create-nginx:
	.scripts/nginx_gen.sh
create-doc:
	poetry run mkdocs build
create-cov-dir:
	poetry run coverage run -m pytest -s --disable-pytest-warnings tests/test_version.py && poetry run coverage html
create-cov:
	make create-cov-dir && poetry run coverage run -m pytest -s --disable-pytest-warnings && poetry run coverage html
start:
	poetry run python python_template/app.py
test:
	poetry run pytest
docker-build:
	docker-compose build
docker-up:
	docker-compose up
docker-down:
	docker-compose down
.PHONY: install build pre-commit fmt-black lint-black lint-flake8 lint-mypy lint test
