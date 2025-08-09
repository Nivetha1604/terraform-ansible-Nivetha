module "resource_group" {
  source              = "./modules/resource_group"
  resource_group_name = "n01725290-rg"
  location            = "Canada Central"
}

# resource "null_resource" "ansible_playbook" {
#   provisioner "local-exec" {
#     command = "ansible-playbook -i ../ansible/hosts.ini ../ansible/n01725290-playbook.yml"
#   }
#   depends_on = [
#     module.linux_vm
#   ]
# }

module "vnet" {
  source              = "./modules/vnet"
  vnet_name           = "n01725290-vnet"
  address_space       = "10.0.0.0/16"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.resource_group_name
  subnet_id           = module.subnet.subnet_id
}

module "subnet" {
  source               = "./modules/subnet"
  subnet_name          = "n01725290-subnet"
  resource_group_name  = module.resource_group.resource_group_name
  virtual_network_name = module.vnet.vnet_name
  address_prefix       = "10.0.1.0/24"
}

module "linux_vm" {
  source   = "./modules/linux_vm"
  for_each = { for i in range(1, 4) : "vm${i}" => i }

  vm_name          = "n01725290-linux-${each.key}"
  nic_name         = "n01725290-${each.key}-nic"
  data_disk_name   = "n01725290-${each.key}-data-disk"
  rg_name          = module.resource_group.resource_group_name
  location         = module.resource_group.location
  vm_size          = "Standard_B1s"
  admin_username   = "user100"
  public_key_path  = "/home/n01725290/.ssh/ccgc_id.pub"
  private_key_path = "/home/n01725290/.ssh/ccgc_id"
  subnet_id        = module.subnet.subnet_id
}

