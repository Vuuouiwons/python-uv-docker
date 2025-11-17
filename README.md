# FastAPI + uv + Docker
A minimal reference template for running **FastAPI** with the **uv package manager** and **Docker**.
Includes a clean project structure, a `.venv` managed by uv.

## Local Development
Install dependencies:
```bash
uv sync --locked
```

Add new packages:
```bash
uv add <package-name>
```

## Docker
Build & run:
```bash
docker compose up --build
```

## Project Layout
```
.gitignore
.dockerignore
.python-version
docker-compose.yml
pyproject.toml
uv.lock
Dockerfile
src/
  main.py
```
