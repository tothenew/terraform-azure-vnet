# Create the VNet using the vnet module 

module "vnet" {
  source = "./modules/vnet"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location 
  vnet_name           = var.vnet_name
  vnet_cidr_block     = var.vnet_cidr_block
  subnets             = var.subnets
  nsg_name            = var.nsg_name
  route_table_name    = var.route_table_name 
  subnet_type         = var.subnet_type
  num_simple_subnets  = var.num_simple_subnets 
  project_name_prefix = var.project_name_prefix
  environment         = var.environment 
  common_tags         = var.common_tags
}