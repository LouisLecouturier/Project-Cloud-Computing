resource "azurerm_resource_group" "rg" {
  name     = "projet-final-rg"
  location = var.rg_location
}


module "postgres-db" {
  source                    = "./postgres-db"
  location                  = azurerm_resource_group.rg.location
  rg_name                   = azurerm_resource_group.rg.name
  pg_admin_username         = var.pg_admin_username
  pg_admin_password         = var.pg_admin_password
}

module "python-api" {
  source                    = "./python-api"
  location                  = azurerm_resource_group.rg.location
  rg_name                   = azurerm_resource_group.rg.name
}