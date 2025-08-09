output "nic_id" {
  description = "NIC ID for this VM"
  value       = azurerm_network_interface.nic.id
}
