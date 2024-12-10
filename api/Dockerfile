FROM python:3.12-slim AS dependencies

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

# Set PYTHONPATH to include the src directory
ENV PYTHONPATH=/app/src

# Copy the rest of the application code
COPY . /app

EXPOSE 8000


# Command to run the FastAPI app
CMD ["poetry", "run", "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]