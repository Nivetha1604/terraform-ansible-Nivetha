terraform {
  backend "azurerm" {
    resource_group_name  = "rg-5502-backend"
    storage_account_name = "stn01725290tfstate"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

