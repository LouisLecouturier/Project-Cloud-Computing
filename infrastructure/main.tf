resource "azurerm_resource_group" "rg" {
  name     = "projet-final-rg"
  location = var.rg_location
}


module "postgres-db" {
  source   = "./modules/postgres-db"
  location = azurerm_resource_group.rg.location
  rg_name  = azurerm_resource_group.rg.name

  pg_database       = var.pg_database
  pg_admin_username = var.pg_admin_username
  pg_admin_password = var.pg_admin_password


  depends_on = [azurerm_resource_group.rg]

}


module "python-api" {
  source = "./modules/python-api"

  location = azurerm_resource_group.rg.location
  rg_name  = azurerm_resource_group.rg.name

  pg_host           = module.postgres-db.db_host
  pg_database       = var.pg_database
  pg_port           = var.pg_port
  pg_admin_username = var.pg_admin_username
  pg_admin_password = var.pg_admin_password

  depends_on = [azurerm_resource_group.rg]
}
