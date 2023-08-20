# Create the VNet using the vnet module 

module "vnet" {
  source = "./modules/vnet"
  resource_group_name = var.resource_group_name
  location            = var.location 
  vnet_name           = var.vnet_name
  address_space       = var.address_space
  subnets             = var.subnets
  route_table_name    = var.route_table_name 
  subnet_type         = var.subnet_type
  subnet_bits         = var.subnet_bits  
  name_prefix         = local.name_prefix
  common_tags         = var.common_tags 
  default_tags        = var.default_tags 
  pip_name            = var.pip_name
  gateway_name        = var.gateway_name 
  sku                 = var.sku   
  allocation_method   = var.allocation_method 
  virtual_network_peering = var.virtual_network_peering
}