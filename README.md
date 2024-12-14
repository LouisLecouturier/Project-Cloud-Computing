# Project-Cloud-Computing

Project is available at: https://aaxxwrmepywifffkqdcr.azurewebsites.net

## Overview

This project consists of a FastAPI application in Python with a PostgreSQL database. The application provides several endpoints to manage items, users, and baskets.

## Setup

### Prerequisites

-   Python 3.12
-   Poetry
-   Terraform
-   Docker

### Initialization

Go to the infrastructure directory:

```bash
cd infrastructure
```

#### Terraform

Initialize Terraform:

```bash
terraform init
```

#### Plan

Generate and show an execution plan:

```bash
terraform plan -var-file="secrets.tfvars"
```

#### Apply

Apply the changes required to reach the desired state:

```bash
terraform apply -var-file="secrets.tfvars"
```

### Installation

Go to the api directory:

```bash
cd api
```

Install the dependencies using Poetry:

```bash
poetry install
```

### Running the Application

Run the FastAPI application:

```bash
poetry run uvicorn main:app --reload
```

## Continuous Integration

This project uses GitHub Actions for continuous integration. The CI workflow builds and pushes a Docker container image to an Azure Web App when a commit is pushed to the main branch. The workflow is defined in [`.github/workflows/azure-container-webapp.yml`](.github/workflows/azure-container-webapp.yml).

## Endpoints

The following endpoints are available in the application:

-   **Items**

    -   `GET /api/v1/items`: Retrieve all items
    -   `GET /api/v1/items/{id}`: Retrieve a specific item by ID

-   **Baskets**

    -   `GET /api/v1/baskets`: Retrieve all baskets
    -   `GET /api/v1/baskets/user/{id}`: Retrieve a basket for a specific user by ID

-   **Users**
    -   `GET /api/v1/users`: Retrieve all users
    -   `GET /api/v1/users/{id}`: Retrieve a specific user by ID

## Database

The application uses a PostgreSQL database. Ensure that the database is running and accessible before starting the application. The database connection details are configured using environment variables.

## Testing

Go to the api directory:

```bash
cd api
```

Run the tests using Poetry:

```bash
poetry run pytest tests/
```
