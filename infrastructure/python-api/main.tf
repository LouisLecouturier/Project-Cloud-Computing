
resource "azurerm_service_plan" "fastapi-plan" {
  name                = "pythonapp-plan"
  resource_group_name = var.rg_name
  location            = var.location
  os_type             = "Linux"
  sku_name            = "F1"
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
    application_stack {
      python_version = "3.9"
    }

    always_on = false

    app_command_line = "gunicorn -w 4 -k uvicorn.workers.UvicornWorker app:app"
  }

  app_settings = {
    SCM_DO_BUILD_DURING_DEPLOYMENT = "true"
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
