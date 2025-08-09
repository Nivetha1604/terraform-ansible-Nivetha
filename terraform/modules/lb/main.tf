resource "azurerm_public_ip" "lb_pip" {
  name                = var.pip_name
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_lb" "this" {
  name                = var.lb_name
  location            = var.location
  resource_group_name = var.rg_name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = var.frontend_name
    public_ip_address_id = azurerm_public_ip.lb_pip.id
  }
}

resource "azurerm_lb_backend_address_pool" "bepool" {
  name            = var.backend_pool_name
  loadbalancer_id = azurerm_lb.this.id
}

resource "azurerm_lb_probe" "http" {
  name                = var.probe_name
  loadbalancer_id     = azurerm_lb.this.id
  protocol            = "Tcp"
  port                = 80
  interval_in_seconds = 5
  number_of_probes    = 2
}

resource "azurerm_lb_rule" "http" {
  name                           = var.rule_name
  loadbalancer_id                = azurerm_lb.this.id
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = var.frontend_name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.bepool.id]
  probe_id                       = azurerm_lb_probe.http.id
}

# Look up NICs by name in the RG, then associate them to the backend pool
data "azurerm_network_interface" "nics" {
  for_each            = toset(var.nic_names)
  name                = each.value
  resource_group_name = var.rg_name
}

resource "azurerm_network_interface_backend_address_pool_association" "nic_assoc" {
  for_each                = data.azurerm_network_interface.nics
  network_interface_id    = each.value.id
  ip_configuration_name   = "internal" # matches your NIC ip_configuration name
  backend_address_pool_id = azurerm_lb_backend_address_pool.bepool.id
}
