output "vnet_name" {
  value = module.vnet_main.vnet_name
}

output "nsg_ids" {
  value = module.vnet_main.nsg_ids
}

output "main_route_table_id" {
  value = module.vnet_main.main_route_table_id
}

output "subnet_ids" {
  value = module.vnet_main.subnet_ids
}

output "vnet_id" {
  value = module.vnet_main.vnet_id
}

output "nat_gateway_ids" {
  value = module.vnet_main.nat_gateway_ids
}

output "location" {
  value = azurerm_resource_group.main.location
}

output "resource_group_name" {
  value = azurerm_resource_group.main.name
}
