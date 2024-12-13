output "vnet_name" {
  description = "Virtual network name"
  value       = azurerm_virtual_network.vnet.name
}

output "vnet_id" {
  description = "Virtual network ID"
  value       = azurerm_virtual_network.vnet.id
}

output "database_subnet_id" {
  description = "Subnet ID"
  value       = azurerm_subnet.database_subnet.id
}

output "app_subnet_id" {
  description = "App subnet ID"
  value       = azurerm_subnet.app_subnet.id
}

