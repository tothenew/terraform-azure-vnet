output "vnet_name" {
  value = module.vnet_main.vnet_name
}

output "vnet_id" {
  value = module.vnet_main.vnet_id
}

output "location" {
  value = azurerm_resource_group.main.location
}

output "resource_group_name" {
  value = azurerm_resource_group.main.name
}
