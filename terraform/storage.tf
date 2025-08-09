locals {
  sa_name = "stn01725290" # must be globally unique, all lowercase, 3–24 chars
  tags = {
    Project        = "CCGC 5502 Automation Project"
    Name           = "n01725290"
    ExpirationDate = "2024-12-31"
    Environment    = "Project"
  }
}

resource "azurerm_storage_account" "sa" {
  name                     = local.sa_name
  resource_group_name      = module.resource_group.resource_group_name
  location                 = module.resource_group.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"

  tags = local.tags
}


resource "azurerm_storage_share" "files" {
  name                 = "files"
  storage_account_name = azurerm_storage_account.sa.name
  quota                = 50 # GB
}

# Blob container (for logs/artifacts)
resource "azurerm_storage_container" "webblob" {
  name                  = "webblob"
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "private"
}
