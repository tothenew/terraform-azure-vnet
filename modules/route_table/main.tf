locals {
  create_route_table = [for s in var.subnets : s if s.associate_with_route_table == true][0]  
}

resource "azurerm_route_table" "main" {
  count               = local.create_route_table != null ? 1 : 0
  name                = var.route_table_name
  resource_group_name = var.resource_group_name
  location            = var.location

  # Define routes for the public route table, including the default route pointing to the Internet Gateway 
  # route {
  #   name                   = "default-route"
  #   address_prefix         = "0.0.0.0/0"
  #   next_hop_type          = "Internet"
  # }
}  




