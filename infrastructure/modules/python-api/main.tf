resource "azurerm_service_plan" "fastapi-plan" {
  name                = "pythonapp-plan"
  resource_group_name = var.rg_name
  location            = var.location
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "random_string" "webapp_name" {
  count   = 1
  length  = 20
  upper   = false
  special = false
  numeric = false
}


locals {
  local_webapp_name = random_string.webapp_name[0].result
}


resource "azurerm_linux_web_app" "fastapi-app" {
  name                = local.local_webapp_name
  resource_group_name = var.rg_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.fastapi-plan.id

  site_config {
    always_on        = false
  }

 app_settings = {
    WEBSITES_PORT = "8000" # Port exposé par votre application
    PYTHON_ENABLE_GUNICORN = "1"
    DOCKER_REGISTRY_SERVER_URL = "https://ghcr.io"
    DOCKER_CUSTOM_IMAGE_NAME = "ghcr.io/louislecouturier/project-cloud-computing:latest"
    DATABASE_HOST                  = var.pg_host
    DATABASE_NAME                  = var.pg_database
    DATABASE_USER                  = var.pg_admin_username
    DATABASE_PASSWORD              = var.pg_admin_password
  }

  timeouts {
    create = "30m"
    update = "30m"
  }
}


resource "azurerm_app_service_source_control" "fastapi-source-control" {
  app_id                 = azurerm_linux_web_app.fastapi-app.id
  repo_url               = "https://github.com/LouisLecouturier/Project-Cloud-Computing.git"
  branch                 = "main"
  use_manual_integration = true
}
