# === Public Load Balancer for the 3 Linux VMs ===
locals {
  vm_names  = ["n01725290-linux-vm1", "n01725290-linux-vm2", "n01725290-linux-vm3"]
  nic_names = [for n in local.vm_names : "${n}-nic"]
}

module "lb" {
  source   = "./modules/lb"
  rg_name  = module.resource_group.resource_group_name
  location = module.resource_group.location

  lb_name           = "n01725290-lb"
  pip_name          = "n01725290-lb-pip"
  frontend_name     = "n01725290-fe"
  backend_pool_name = "n01725290-bepool"
  probe_name        = "n01725290-http-probe"
  rule_name         = "n01725290-http-rule"

  vm_names  = local.vm_names
  nic_names = local.nic_names

  depends_on = [module.linux_vm]
}

output "lb_public_ip" {
  value = module.lb.lb_public_ip
}
