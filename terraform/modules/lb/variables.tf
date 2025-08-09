variable "rg_name" {
  description = "Resource Group name"
  type        = string
}

variable "location" {
  description = "Azure location"
  type        = string
}

variable "lb_name" {
  description = "Load Balancer name"
  type        = string
}

variable "pip_name" {
  description = "Public IP name for the LB"
  type        = string
}

variable "frontend_name" {
  description = "Frontend IP config name"
  type        = string
}

variable "backend_pool_name" {
  description = "Backend pool name"
  type        = string
}

variable "probe_name" {
  description = "Probe name"
  type        = string
}

variable "rule_name" {
  description = "LB rule name"
  type        = string
}

variable "nic_names" {
  description = "NIC names to associate with backend pool"
  type        = list(string)
}

variable "vm_names" {
  description = "List of VM names"
  type        = list(string)
}

