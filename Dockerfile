FROM python:3.12-slim as base

RUN apt-get update \
    && apt-get install -y git curl

ENV POETRY_NO_INTERACTION=1
ENV POETRY_HOME="/opt/poetry"
ENV PATH="$POETRY_HOME/bin:$PATH"

RUN curl -sSL https://install.python-poetry.org | python3 -
COPY poetry.lock pyproject.toml ./


RUN poetry config virtualenvs.create false \
    && poetry config installer.max-workers 10 \
    && poetry install --no-root --no-directory --without dev

COPY ./hello_world ./hello_world

FROM base as test

RUN poetry install --only dev
COPY ./tests ./tests
CMD pytest tests/hello_world.py


FROM base as runtime
CMD hello_world/python3 main.py




