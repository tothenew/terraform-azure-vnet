variable "resource_group_name" {
  description = "Name of the resource group."
  type        = string
  default     = "my-vnet-rg"
}

variable "location" {
  description = "Azure region where resources will be deployed."
  type        = string
  default     = "eastus"
}

variable "vnet_name" {
  description = "Name of the virtual network."
  type        = string
  default     = "my-vnet"
}

variable "route_table_name" {
  type    = string
  default = "vnet_route_table"
}

variable "gateway_name" {
  description = "The name of this NAT gateway."
  type        = string
  default     = "vnet-nat-gateway"
}

variable "pip_name" {
  description = "The name of the public ip"
  type        = string
  default     = "public_ip"
}

variable "address_space" {
  description = "CIDR block for the virtual network."
  type        = string
  default     = "10.0.0.0/16"
}

variable "sku" {
  description = "The SKU for this public IP address."
  type        = string
  default     = "Standard"
}

variable "allocation_method" {
  description = "The allocation method to use for this public IP address."
  type        = string
  default     = "Static"
}

variable "subnets" {
  description = "Map of subnets and their CIDR blocks."
  type = map(object({
    address_prefixes           = list(string)
    associate_with_route_table = bool
    is_nsg                     = optional(bool, false)
    network_security_group_association = optional(object({
      security_rules = optional(list(object({
        name                       = string
        priority                   = number
        direction                  = string
        access                     = string
        protocol                   = string
        source_port_range          = string
        destination_port_range     = string
        source_address_prefix      = string
        destination_address_prefix = string
      })), [])
    }))

    is_natgateway      = optional(bool, false)
    service_delegation = optional(bool, false)
    delegation_name    = optional(string, "")
    delegation_actions = optional(list(string), [])
    service_endpoints  = optional(list(string), [])
  }))

  default = {}
}

variable "subnet_type" {
  description = "Type of subnets to create (simple or dynamic)"
  type        = string
  default     = "subnet_simple"
}

variable "subnet_bits" {
  description = "Number of simple subnets to create"
  type        = number
  default     = 0
}

variable "common_tags" {
  type        = map(string)
  description = "A map of tags to add to all resources"
  default = {
    Project    = "VNet"
    Managed-By = "TTN"
  }
}

variable "name_prefix" {
  type        = string
  description = "A project name prefix for Route Table"
  default     = "vnet"
}

variable "default_tags" {
  type        = map(string)
  description = "A map to add common tags to all the resources"
  default = {
    "Scope" : "VNET-SETUP"
    "CreatedBy" : "Terraform"
  }
}

variable "virtual_network_peering" {
  description = "Flag to determine if virtual network peering should be created."
  type        = bool
  default     = false
}

