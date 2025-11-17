FROM python:3.14-alpine AS builder

WORKDIR /app

RUN --mount=from=ghcr.io/astral-sh/uv,source=/uv,target=/bin/uv \
    --mount=type=cache,target=/root/.cache/uv \
    --mount=type=bind,source=uv.lock,target=uv.lock \
    --mount=type=bind,source=pyproject.toml,target=pyproject.toml \
    uv sync --locked --no-install-project --no-editable

ADD uv.lock .
ADD .python-version .
ADD pyproject.toml .

RUN --mount=from=ghcr.io/astral-sh/uv,source=/uv,target=/bin/uv \
    --mount=type=cache,target=/root/.cache/uv \
    uv sync --locked --no-editable

ENV PATH="/app/.venv/bin/:$PATH"

ADD src .

EXPOSE 8000

CMD ["fastapi", "run", "--host", "0.0.0.0", "--workers", "4", "main.py"]