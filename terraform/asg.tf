# === Application Security Groups ===
resource "azurerm_application_security_group" "web_asg" {
  name                = "n01725290-web-asg"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.resource_group_name
  tags = {
    Project        = "CCGC 5502 Automation Project"
    Name           = "n01725290"
    ExpirationDate = "2024-12-31"
    Environment    = "Project"
  }
}

resource "azurerm_application_security_group" "ssh_asg" {
  name                = "n01725290-ssh-asg"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.resource_group_name
  tags = {
    Project        = "CCGC 5502 Automation Project"
    Name           = "n01725290"
    ExpirationDate = "2024-12-31"
    Environment    = "Project"
  }
}

# === Associate web_asg with each NIC ===
resource "azurerm_network_interface_application_security_group_association" "vm1_web" {
  network_interface_id          = module.linux_vm["vm1"].nic_id
  application_security_group_id = azurerm_application_security_group.web_asg.id
}

resource "azurerm_network_interface_application_security_group_association" "vm2_web" {
  network_interface_id          = module.linux_vm["vm2"].nic_id
  application_security_group_id = azurerm_application_security_group.web_asg.id
}

resource "azurerm_network_interface_application_security_group_association" "vm3_web" {
  network_interface_id          = module.linux_vm["vm3"].nic_id
  application_security_group_id = azurerm_application_security_group.web_asg.id
}
