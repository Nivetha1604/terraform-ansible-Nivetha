output "public_ip" {
  description = "Public IP of the Linux VM"
  value       = azurerm_public_ip.pip.ip_address
}

output "private_ip" {
  description = "Private IP of the Linux VM"
  value       = azurerm_network_interface.nic.private_ip_address
}

output "vm_id" {
  description = "ID of the Linux VM"
  value       = azurerm_linux_virtual_machine.vm.id
}

