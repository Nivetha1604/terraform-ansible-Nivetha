variable "vm_name" {
  description = "Name of the Linux VM"
  type        = string
}

variable "rg_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "vm_size" {
  description = "Size of the VM"
  type        = string
  default     = "Standard_B1s"
}

variable "admin_username" {
  description = "Admin username for the VM"
  type        = string
}

variable "public_key_path" {
  description = "Path to the public SSH key"
  type        = string
}
variable "subnet_id" {
  description = "Subnet ID to attach to the VM"
  type        = string
}
variable "nic_name" {
  description = "Name of the network interface"
  type        = string
}

variable "data_disk_name" {
  description = "Name of the managed data disk"
  type        = string
}
variable "private_key_path" {
  description = "Path to the private SSH key for remote-exec"
  type        = string
}
