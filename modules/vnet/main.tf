resource "azurerm_virtual_network" "main" {
  name                = var.vnet_name
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = [var.vnet_cidr_block]

  tags = merge(var.common_tags, tomap({
    "Name" : "${var.project_name_prefix}-${var.environment}"
  })) 
}

# Create subnets in the VNet dynamically using the subnets module

module "subnets" {
  source = "../subnets"
  resource_group_name = var.resource_group_name
  vnet_name           = azurerm_virtual_network.main.name
  location            = var.location
  subnets             = var.subnets
  num_simple_subnets  = var.num_simple_subnets
  subnet_type         = var.subnet_type
  project_name_prefix = var.project_name_prefix
  environment         = var.environment 
  common_tags         = var.common_tags
}

# Create the NSG using the nsg module
module "nsg" {
  source = "../nsg"
  resource_group_name = var.resource_group_name
  location            = var.location
  nsg_name            = var.nsg_name
}

# Create the Route Table using the route_table module
module "route_table" {
  source = "../route_table"
  resource_group_name = var.resource_group_name
  location            = var.location
  route_table_name    = var.route_table_name
  project_name_prefix = var.project_name_prefix
  environment         = var.environment 
  common_tags         = var.common_tags
  subnet_type         = var.subnet_type 
  subnets             = var.subnets 
}


############################################################################################################################
######################  If creating advance subnets, associate NSG and Route Table with dynamic subnets   ##################
############################################################################################################################

resource "azurerm_subnet_network_security_group_association" "dynamic_nsg_association" {
  for_each             = var.subnet_type == "advance" ? var.subnets : {}
  subnet_id            = module.subnets.subnet_ids[each.key]
  network_security_group_id = module.nsg.nsg_id
}

resource "azurerm_subnet_route_table_association" "dynamic_route_table_association" {
  for_each       = var.subnet_type == "advance" ? { for name, subnet in var.subnets : name => subnet if subnet.is_public == true } : {} 
  subnet_id      = module.subnets.subnet_ids[each.key]
  route_table_id = module.route_table.main_route_table_id
}

resource "azurerm_subnet_route_table_association" "advance_route_table_association" {
  for_each       = { for name, subnet in var.subnets : name => subnet if subnet.is_public == false }
  subnet_id      = module.subnets.subnet_ids[each.key]
  route_table_id = module.route_table.advance_route_table_ids[0] 
}


############################################################################################################################### 
##################    If creating simple subnets, associate NSG and Route Table with simple subnets   #####################
###############################################################################################################################

resource "azurerm_subnet_network_security_group_association" "simple_nsg_association" {
  count                     = var.subnet_type == "simple" ? var.num_simple_subnets : 0
  subnet_id                 = module.subnets.subnet_ids_simple[count.index] 
  network_security_group_id = module.nsg.nsg_id
}

resource "azurerm_subnet_route_table_association" "simple_route_table_association" {
  count          = var.subnet_type == "simple" ? var.num_simple_subnets : 0
  subnet_id      = module.subnets.subnet_ids_simple[count.index] 
  route_table_id = module.route_table.main_route_table_id
}

