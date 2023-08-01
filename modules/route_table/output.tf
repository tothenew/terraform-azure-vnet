output "main_route_table_id" {
  value = azurerm_route_table.main.id
}

output "advance_route_table_ids" {
  value = var.subnet_type == "advance" ? tolist(azurerm_route_table.advance)[*].id : []
}


