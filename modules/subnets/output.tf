output "subnet_ids" {
  value = { for subnet in azurerm_subnet.subnets : subnet.name => subnet.id }
} 

output "subnet_ids_simple" {
  value = var.subnet_type == "simple" ? azurerm_subnet.simple_subnets.*.id : []
} 