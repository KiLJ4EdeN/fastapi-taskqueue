# Dockerfile
FROM python:3.8-slim
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_NO_CACHE_DIR=off \
    PIP_DISABLE_PIP_VERSION_CHECK=on \
    PIP_DEFAULT_TIMEOUT=100 \
    POETRY_HOME="/opt/poetry" \
    POETRY_VIRTUALENVS_IN_PROJECT=true \
    POETRY_NO_INTERACTION=1 \
    PYSETUP_PATH="/opt/pysetup" \
    VENV_PATH="/opt/pysetup/.venv"

ENV PATH="$POETRY_HOME/bin:$VENV_PATH/bin:$PATH"

RUN apt-get update \
    && apt-get install --no-install-recommends -y \
        curl \
        build-essential

# Install Poetry - respects $POETRY_VERSION & $POETRY_HOME
ENV POETRY_VERSION=1.2.0
RUN curl -sSL https://install.python-poetry.org | python3

# We copy our Python requirements here to cache them
# and install only runtime deps using poetry
COPY . /code
WORKDIR /code

# Add .env
ADD .env /code/.env

RUN make create-nginx
# dont use lock since can be different poetry versions
RUN rm -rf poetry.lock
# clean any extra cache file
RUN make clean
RUN make install
RUN make build
# run tests and create docs
RUN make test
RUN make create-doc
# RUN make cover-test
