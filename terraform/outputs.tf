output "linux_vm_private_ips" {
  description = "Private IPs of all Linux VMs"
  value = {
    for k, vm in module.linux_vm : k => vm.private_ip
  }
}

output "linux_vm_public_ips" {
  description = "Public IPs of all Linux VMs"
  value = {
    for k, vm in module.linux_vm : k => vm.public_ip
  }
}

output "linux_vm_ids" {
  description = "IDs of all Linux VMs"
  value = {
    for k, vm in module.linux_vm : k => vm.vm_id
  }
}

