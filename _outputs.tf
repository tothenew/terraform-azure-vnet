output "subnet_ids" {
  value = { for subnet in azurerm_subnet.subnet_main : subnet.name => subnet.id }
}

output "nsg_ids" {
  value = {
    for subnet_key, nsg in azurerm_network_security_group.main :
    subnet_key => nsg.id
  }
}

output "main_route_table_id" {
  value = length(azurerm_route_table.main) > 0 ? azurerm_route_table.main[0].id : null
}

output "nat_gateway_ids" {
  value = {
    for subnet_key, nat_gateway in azurerm_nat_gateway.nat :
    subnet_key => nat_gateway.id
  }
}

output "vnet_id" {
  value = azurerm_virtual_network.main.id
}

output "vnet_name" {
  value = azurerm_virtual_network.main.name
}

