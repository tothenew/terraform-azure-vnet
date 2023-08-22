locals {
  location       = var.location 
  resource_group = var.resource_group_name 
  name_prefix  = "${var.name_prefix}" 

  create_route_table = [for s in var.subnets : s if s.associate_with_route_table == true]
  subnet_names = keys(var.subnets)
  create_simple_subnets  = var.subnet_type == "subnet_simple"
} 

