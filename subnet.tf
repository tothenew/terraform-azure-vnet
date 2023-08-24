resource "azurerm_subnet" "subnet_main" {
  for_each             = var.subnets
  name                 = each.key
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet_name
  address_prefixes     = each.value["address_prefixes"]

  service_endpoints = each.value.service_endpoints

  dynamic "delegation" {
    for_each = each.value.service_delegation ? [1] : []
    content {
      name = "delegation"

      service_delegation {
        name    = each.value.delegation_name
        actions = each.value.delegation_actions
      }
    }

  }
}


###  CREATE SIMPLE SUBNET 
resource "azurerm_subnet" "subnet_simple" {
  count                = var.subnet_type == "subnet_simple" ? var.subnet_bits : 0
  name                 = "subnet-simple-${count.index + 1}"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet_name
  address_prefixes     = ["10.0.${count.index + 1}.0/24"]
}
