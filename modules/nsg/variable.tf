variable "resource_group_name" {
  description = "Name of the resource group."
  type        = string
}

variable "location" {
  description = "Azure region where resources will be deployed."
  type        = string
}

variable "nsg_name" {
  description     = "Name of the NSG"
  type            = string
} 