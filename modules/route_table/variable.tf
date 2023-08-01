variable "resource_group_name" {
  description = "Name of the resource group."
  type        = string
}

variable "location" {
  description = "Azure region where resources will be deployed."
  type        = string
}

variable "route_table_name" {
  type = string
}

variable "common_tags" {
  type        = map(string)
  description = "A map of tags to add to all resources"
}

variable "project_name_prefix" {
  type        = string
  description = "A project name prefix for Route Table"
}

variable "environment" {
  type        = string
  description = "An Name for Route Table of the environment"
} 

variable "subnet_type" {
  description = "Type of subnets to create (simple or dynamic)"
  type        = string
}

variable "subnets" {
  description = "Map of subnets and their CIDR blocks."
  type        = map(object({
    cidr_block = string
    is_public   = bool
  }))
}

