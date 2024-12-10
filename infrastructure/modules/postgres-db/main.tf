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


resource "azurerm_postgresql_flexible_server" "projet_cloud_pg_server" {
  name                = local.local_pg_account_name
  location            = var.location
  resource_group_name = var.rg_name

  version  = "14"
  sku_name = "B_Standard_B1ms"

  storage_mb                   = 32768
  backup_retention_days        = 7
  geo_redundant_backup_enabled = false
  auto_grow_enabled            = false

  public_network_access_enabled = true # for demo purposes

  administrator_login    = var.pg_admin_username
  administrator_password = var.pg_admin_password

  authentication {
    password_auth_enabled = true
  }


  lifecycle {
    create_before_destroy = true
  }

  zone = "1"

}

# Add this after your azurerm_postgresql_flexible_server resource
resource "azurerm_postgresql_flexible_server_firewall_rule" "allow_azure_services" {
  server_id = azurerm_postgresql_flexible_server.projet_cloud_pg_server.id
  name      = "allow-azure-services"

  start_ip_address = "0.0.0.0"
  end_ip_address   = "255.255.255.255"
}

resource "azurerm_postgresql_flexible_server_database" "pg_db" {
  name = var.pg_database

  server_id = azurerm_postgresql_flexible_server.projet_cloud_pg_server.id
  charset   = "UTF8"

  # prevent the possibility of accidental data loss
  lifecycle {
    prevent_destroy = true

  }
}
