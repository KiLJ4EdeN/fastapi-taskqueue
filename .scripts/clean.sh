# remove env, why tho
# rm -rf .venv
# cov
rm -rf coverage
rm -rf .coverage
# pytest cache, pycache, mypy cache
find . -name "__pycache__" -type d | xargs rm -rf
find . -name ".pytest_cache" -type d | xargs rm -rf
find . -name ".mypy_cache" -type d | xargs rm -rf
# build and docs
rm -rf dist
rm -rf site
