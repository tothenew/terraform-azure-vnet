output "vnet_id" {
  value = azurerm_virtual_network.main.id
}

output "vnet_name" {
  value = azurerm_virtual_network.main.name
}

output "nsg_ids" {
 value = module.nsg_main.nsg_ids
}

output "main_route_table_id" {
  value = module.route_table.main_route_table_id
}

output "subnet_ids" {
  value = module.subnets.subnet_ids
}

output "nat_gateway_ids" {
  value = module.subnets.nat_gateway_ids
}
