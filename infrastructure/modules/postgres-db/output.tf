

output "db_host" {
  value = azurerm_postgresql_flexible_server.projet_cloud_pg_server.fqdn

}

output "db_port" {
  value       = 5432
  description = "Port of the database instance"
}
