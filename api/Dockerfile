FROM python:3.12-slim AS dependencies

ENV PYTHONUNBUFFERED=1
ENV PORT=8000
ENV PYTHONPATH=/app:$PYTHONPATH

WORKDIR /app

COPY pyproject.toml poetry.lock /app/

# Install Poetry
RUN pip install poetry --quiet

# Install dependencies
RUN poetry install --no-root --no-dev

# Use the official Python image from the Docker Hub
FROM dependencies AS build

# Set the working directory
WORKDIR /app

# Copy the dependencies from the previous stage
COPY --from=dependencies /app /app

# Copy the rest of the application code
COPY . /app

# Add healthcheck
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:8000/health || exit 1

EXPOSE 8000

# Command to run the FastAPI app
CMD ["poetry", "run", "gunicorn", "main:app", \
     "--workers", "2", \
     "--worker-class", "uvicorn.workers.UvicornWorker", \
     "--bind", "0.0.0.0:8000", \
     "--log-level", "debug", \
     "--timeout", "120", \
     "--access-logfile", "-", \
     "--error-logfile", "-"]