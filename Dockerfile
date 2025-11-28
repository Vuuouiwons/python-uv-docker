FROM python:3.14-alpine AS builder

RUN adduser -D static

WORKDIR /home/static/app

RUN --mount=from=ghcr.io/astral-sh/uv,source=/uv,target=/bin/uv \
    --mount=type=bind,source=uv.lock,target=uv.lock \
    --mount=type=bind,source=pyproject.toml,target=pyproject.toml \
    --mount=type=bind,source=.python-version,target=.python-version \
    --mount=type=cache,target=/root/.cache/uv \
    uv sync --locked --no-install-project --no-editable

RUN --mount=from=ghcr.io/astral-sh/uv,source=/uv,target=/bin/uv \
    --mount=type=bind,source=uv.lock,target=uv.lock \
    --mount=type=bind,source=pyproject.toml,target=pyproject.toml \
    --mount=type=bind,source=.python-version,target=.python-version \
    --mount=type=cache,target=/root/.cache/uv \
    uv sync --locked --no-editable

ENV PATH="/home/static/app/.venv/bin/:$PATH"

COPY src .

USER static

EXPOSE 8000

CMD ["fastapi", "run", "--host", "0.0.0.0", "--workers", "4", "main.py"]