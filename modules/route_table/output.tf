# output "main_route_table_id" {
#   value = local.create_route_table ? azurerm_route_table.main[0].id : null
# }
# output "main_route_table_id" {
#   value = local.create_route_table ? tolist(azurerm_route_table.main)[*].id : []
# }  
output "main_route_table_id" {
  value = azurerm_route_table.main[0].id
} 