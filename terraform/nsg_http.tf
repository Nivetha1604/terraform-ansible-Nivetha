# Allow HTTP inbound (port 80) on the existing NSG created in the vnet module
resource "azurerm_network_security_rule" "allow_http" {
  name                        = "Allow-HTTP"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"

  resource_group_name         = module.resource_group.resource_group_name
  network_security_group_name = "n01725290-vnet-nsg"

  # ensure the NSG from module.vnet exists before we add the rule
  depends_on = [module.vnet]
}

