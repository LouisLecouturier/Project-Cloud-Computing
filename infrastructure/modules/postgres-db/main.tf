resource "azurerm_private_dns_zone" "my_dns_zone" {
  name                = "privatelink.postgres.database.azure.com"
  resource_group_name = var.rg_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "my_dns_zone_link" {
  name                  = "my_dns_zone_link"
  resource_group_name   = var.rg_name
  private_dns_zone_name = azurerm_private_dns_zone.my_dns_zone.name
  virtual_network_id    = var.vnet_id

}


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

  version    = "14"
  sku_name   = "B_Standard_B1ms"
  depends_on = [azurerm_private_dns_zone_virtual_network_link.my_dns_zone_link]

  storage_mb                   = 32768
  backup_retention_days        = 7
  geo_redundant_backup_enabled = false
  auto_grow_enabled            = false

  public_network_access_enabled = false
  delegated_subnet_id           = var.db_subnet
  private_dns_zone_id           = azurerm_private_dns_zone.my_dns_zone.id

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
resource "azurerm_postgresql_flexible_server_database" "pg_db" {
  name = var.pg_database

  server_id = azurerm_postgresql_flexible_server.projet_cloud_pg_server.id
  charset   = "UTF8"

  # prevent the possibility of accidental data loss
  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_postgresql_flexible_server_firewall_rule" "allow_webapp" {
  name             = "AllowWebApp"
  server_id        = azurerm_postgresql_flexible_server.projet_cloud_pg_server.id
  start_ip_address = "10.0.2.0" # IP address of the app subnet
  end_ip_address   = "10.0.2.255"
}


