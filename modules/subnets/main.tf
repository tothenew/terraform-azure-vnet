locals {
  subnet_names = keys(var.subnets)
  create_advance_subnets = var.subnet_type == "advance"
  create_simple_subnets  = var.subnet_type == "simple"
}


resource "azurerm_subnet" "subnets" {
  for_each             = var.subnet_type == "advance" ? var.subnets : {}
  name                 = each.key
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet_name
  address_prefixes     = [each.value.cidr_block]  
}

resource "azurerm_public_ip" "nat_public_ip" {
  for_each             = { for name, subnet in var.subnets : name => subnet if subnet.is_public == false }
  name                = "nat-public-ip-${each.key}"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = merge(var.common_tags, tomap({
    "Name" : "${var.project_name_prefix}-${var.environment}"
  })) 
}

locals {
  matching_subnets = [for subnet in var.subnets : subnet if var.subnet_type == "advance" && subnet.is_public == false]
}

resource "azurerm_nat_gateway" "main" {
  count                   = length(local.matching_subnets) > 0 ? 1 : 0
  name                    = "nat-gateway"
  location                = var.location
  resource_group_name     = var.resource_group_name
  sku_name                = "Standard"
  idle_timeout_in_minutes = 10
} 


resource "azurerm_nat_gateway_public_ip_association" "example" {
  for_each             = { for name, subnet in var.subnets : name => subnet if subnet.is_public == false }
  nat_gateway_id       = azurerm_nat_gateway.main[0].id
  public_ip_address_id = azurerm_public_ip.nat_public_ip[each.key].id  
} 




####  CREATE SIMPLE SUBNET 
resource "azurerm_subnet" "simple_subnets" {
  count                = var.subnet_type == "simple" ? var.num_simple_subnets : 0
  name                 = "simple-subnet-${count.index + 1}"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet_name
  address_prefixes     = ["10.0.${count.index + 1}.0/24"] 
}