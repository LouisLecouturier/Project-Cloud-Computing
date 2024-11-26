resource "random_string" "db_account_name" {
  count = var.pg_account_name == null ? 1 : 0

  length  = 20
  upper   = false
  special = false
  numeric = false
}


locals {
  local_pg_account_name = try(random_string.db_account_name[0].result, var.pg_account_name)
}



resource "azurerm_postgresql_server" "pg_server" {
  name                    = local.local_pg_account_name
  location                = var.location
  resource_group_name     = var.rg_name
  ssl_enforcement_enabled = true
  version                 = "11"
  sku_name                = "B_Gen5_1"

  storage_mb                   = 5120
  backup_retention_days        = 7
  geo_redundant_backup_enabled = false
  auto_grow_enabled            = false

  administrator_login          = var.pg_admin_username
  administrator_login_password = var.pg_admin_password
}


resource "azurerm_postgresql_database" "pg_db" {
  name                = "projet-final-db"
  resource_group_name = var.rg_name
  server_name         = azurerm_postgresql_server.pg_server.name
  charset             = "UTF8"
  collation           = "English_United States.1252"

  # prevent the possibility of accidental data loss
  lifecycle {
    prevent_destroy = true
  }
}