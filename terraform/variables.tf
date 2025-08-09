variable "vm_size" {
  description = "Size of the VM"
  type        = string
  default     = "Standard_B1s"
}

variable "public_key_path" {
  description = "Path to the public SSH key"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "admin_username" {
  description = "Admin username for the VM"
  type        = string
  default     = "user100"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "canadacentral"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "n01725290-rg"
}
variable "my_ip_cidr" {
  description = "Your public IP in CIDR, e.g. 203.0.113.5/32"
  type        = string
}
