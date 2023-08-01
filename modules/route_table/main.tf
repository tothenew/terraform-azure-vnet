resource "azurerm_route_table" "main" {
  name                = var.route_table_name
  location            = var.location
  resource_group_name = var.resource_group_name

    tags = merge(var.common_tags, tomap({
    "Name" : "${var.project_name_prefix}-${var.environment}"
  }))
}


locals {
  matching_subnets = [for subnet in var.subnets : subnet if var.subnet_type == "advance" && subnet.is_public == false]
}

resource "azurerm_route_table" "advance" {
  count               = length(local.matching_subnets) > 0 ? 1 : 0
  name                = "advance-route-table"
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = merge(var.common_tags, tomap({
    "Name" : "${var.project_name_prefix}-${var.environment}"
  }))
}


