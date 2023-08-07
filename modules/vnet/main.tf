resource "azurerm_virtual_network" "main" {
  name                = var.vnet_name
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = [var.address_space] 

  tags = merge(var.default_tags, var.common_tags ,  tomap({
    "Name" : var.name_prefix  
  }))  
}

# Create subnets in the VNet dynamically using the subnets module

module "subnets" {
  source = "../subnets"
  resource_group_name = var.resource_group_name
  vnet_name           = azurerm_virtual_network.main.name
  location            = var.location
  subnets             = var.subnets
  subnet_bits         = var.subnet_bits 
  subnet_type         = var.subnet_type
  name_prefix         = var.name_prefix 
  common_tags         = var.common_tags
  default_tags        = var.default_tags 
  pip_name            = var.pip_name
  gateway_name        = var.gateway_name 
  sku                 = var.sku   
  allocation_method   = var.allocation_method 
}

# Create the NSG using the nsg module
module "nsg_main" {
  source = "../nsg"
  resource_group_name = var.resource_group_name
  location            = var.location
  default_tags        = var.default_tags 
  common_tags         = var.common_tags
  name_prefix         = var.name_prefix 
  subnets             = var.subnets
  depends_on = [ module.subnets ]
}

# Create the Route Table using the route_table module
module "route_table" {
  source = "../route_table"
  resource_group_name = var.resource_group_name
  location            = var.location
  route_table_name    = var.route_table_name
  name_prefix         = var.name_prefix 
  common_tags         = var.common_tags 
  subnets             = var.subnets 
  default_tags        = var.default_tags 
  depends_on = [ module.subnets ]  
}

resource "azurerm_subnet_network_security_group_association" "main" {
  for_each                  = { for k, v in var.subnets : k => v if v.is_nsg }  
  subnet_id                 = module.subnets.subnet_ids[each.key]
  network_security_group_id = module.nsg_main.nsg_ids[each.key]

  depends_on = [module.nsg_main] 
}  

resource "azurerm_subnet_nat_gateway_association" "main" { 
  for_each          = { for k, v in var.subnets : k => v if v.is_natgateway }
  nat_gateway_id    = module.subnets.nat_gateway_ids[each.key]  
  subnet_id         = module.subnets.subnet_ids[each.key] 

  depends_on = [ module.subnets ] 
}    

resource "azurerm_subnet_route_table_association" "main" {
  for_each       = { for k, v in var.subnets : k => v if v.associate_with_route_table == true }
  subnet_id      = module.subnets.subnet_ids[each.key]
  route_table_id = module.route_table.main_route_table_id  

  depends_on = [module.subnets, module.route_table]
}  

