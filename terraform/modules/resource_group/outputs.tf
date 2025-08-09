output "resource_group_name" {
  description = "The name of the resource group"
  value       = azurerm_resource_group.rg.name
}
output "location" {
  description = "Location of the resource group"
  value       = azurerm_resource_group.rg.location
}
