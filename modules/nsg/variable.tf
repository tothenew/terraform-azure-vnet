variable "resource_group_name" {
  description = "Name of the resource group."
  type        = string
}

variable "location" {
  description = "Azure region where resources will be deployed."
  type        = string
} 

variable "default_tags" {
  type        = map(string)
  description = "A map to add common tags to all the resources"
}

variable "name_prefix" {
  type        = string
  description = "A project name prefix for Route Table"
}

variable "common_tags" {
  type        = map(string)
  description = "A map of tags to add to all resources"
}

variable "subnets" {
  description = "Map of subnets and their CIDR blocks."
  type        = map(object({
    address_prefixes =  list(string) 
    #is_public   = bool 
    associate_with_route_table = bool  
    is_nsg = optional(bool, false)  
    network_security_group_association = optional(object({
      security_rules            = optional(list(object({
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

    is_natgateway = optional(bool, false) 
  }))

  default = { }
}