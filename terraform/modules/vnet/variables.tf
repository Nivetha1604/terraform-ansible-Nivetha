variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "address_space" {
  description = "Address space for the virtual network"
  type        = string
}

variable "location" {
  description = "Azure region for the virtual network"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name for the VNet"
  type        = string
}
variable "subnet_id" {
  description = "ID of the subnet to associate NSG with"
  type        = string
}
