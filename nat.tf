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

resource "azurerm_nat_gateway_public_ip_association" "nat_pip_association" {
  for_each = { for k, v in var.subnets : k => v if v.is_natgateway }

  nat_gateway_id       = azurerm_nat_gateway.nat[each.key].id
  public_ip_address_id = azurerm_public_ip.pip[each.key].id 
}

resource "azurerm_subnet_nat_gateway_association" "subnet_nat_association" { 
  for_each          = { for k, v in var.subnets : k => v if v.is_natgateway }
  nat_gateway_id    = azurerm_nat_gateway.nat[each.key].id   
  subnet_id         = azurerm_subnet.subnet_main[each.key].id 

  depends_on = [ azurerm_subnet.subnet_main ]  
}  