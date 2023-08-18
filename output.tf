output "location" {
  value = azurerm_resource_group.main.location
}

output "vnet_name" {
  value = module.vnet.vnet_name
}

output "nsg_ids" {
  value = module.vnet.nsg_ids
}

output "main_route_table_id" {
  value = module.vnet.main_route_table_id
}

output "subnet_ids" {
  value = module.vnet.subnet_ids
}

output "vnet_id" {
  value = module.vnet.vnet_id
}

output "nat_gateway_ids" {
  value = module.vnet.nat_gateway_ids
}