resource "azurerm_virtual_network" "main" {
  name                = var.vnet_name
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = [var.address_space] 

  tags = merge(var.default_tags, var.common_tags ,  tomap({
    "Name" : var.name_prefix  
  }))  
}


## VIRTUAL NETWORK PEERING ..............##

resource "azurerm_virtual_network_peering" "peering" {
  count = var.virtual_network_peering ? 1 : 0 
  name                         = "vnet-peering" 
  resource_group_name          = var.resource_group_name
  virtual_network_name         = azurerm_virtual_network.main.name
  remote_virtual_network_id    = azurerm_virtual_network.main.id  
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true

  # `allow_gateway_transit` must be set to false for vnet Global Peering
  allow_gateway_transit = false
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

resource "azurerm_subnet_network_security_group_association" "subnet_nsg_association" {
  for_each                  = { for k, v in var.subnets : k => v if v.is_nsg }  
  subnet_id                 = module.subnets.subnet_ids[each.key]
  network_security_group_id = module.nsg_main.nsg_ids[each.key]

  depends_on = [module.nsg_main] 
}  

resource "azurerm_subnet_nat_gateway_association" "subnet_nat_association" { 
  for_each          = { for k, v in var.subnets : k => v if v.is_natgateway }
  nat_gateway_id    = module.subnets.nat_gateway_ids[each.key]  
  subnet_id         = module.subnets.subnet_ids[each.key] 

  depends_on = [ module.subnets ] 
}    

resource "azurerm_subnet_route_table_association" "subnet_route_table_association" {
  for_each       = { for k, v in var.subnets : k => v if v.associate_with_route_table == true }
  subnet_id      = module.subnets.subnet_ids[each.key]
  route_table_id = module.route_table.main_route_table_id  

  depends_on = [module.subnets, module.route_table]
}  

