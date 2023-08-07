locals {
  subnet_names = keys(var.subnets)
  create_simple_subnets  = var.subnet_type == "subnet_simple"
}

resource "azurerm_subnet" "subnet_main" {
  for_each             = var.subnets
  name                 = each.key 
  resource_group_name  = var.resource_group_name  
  virtual_network_name = var.vnet_name
  address_prefixes     = each.value["address_prefixes"]
 # service_endpoints    = each.value["service_endpoints"] 
} 


resource "azurerm_public_ip" "pip" {
  for_each            = { for k, v in var.subnets : k => v if v.is_natgateway }
  name                = "${var.pip_name}-${each.key}-pip"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku

  # If sku is "Standard", allocation_method must be "Static".
  allocation_method = var.sku == "Standard" ? "Static" : var.allocation_method

  tags = merge(var.default_tags, var.common_tags ,  tomap({
    "Name" : "${var.name_prefix}"
  }))
} 

resource "azurerm_nat_gateway" "nat" {
  for_each            = { for k, v in var.subnets : k => v if v.is_natgateway } 
  name                = "${var.gateway_name}-${each.key}-gateway" 
  resource_group_name = var.resource_group_name
  location            = var.location
  sku_name            = "Standard" 

  tags = merge(var.default_tags, var.common_tags ,  tomap({
    "Name" : "${var.name_prefix}"
  })) 
} 

resource "azurerm_nat_gateway_public_ip_association" "main" {
  for_each = { for k, v in var.subnets : k => v if v.is_natgateway }

  nat_gateway_id       = azurerm_nat_gateway.nat[each.key].id
  public_ip_address_id = azurerm_public_ip.pip[each.key].id 
}




###  CREATE SIMPLE SUBNET 
resource "azurerm_subnet" "simple_subnets" {
  count                = var.subnet_type == "subnet_simple" ? var.subnet_bits : 0
  name                 = "subnet-simple-${count.index + 1}"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet_name
  address_prefixes     = ["10.0.${count.index + 1}.0/24"] 
} 