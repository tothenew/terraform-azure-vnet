output "subnet_ids" {
  value = { for subnet in azurerm_subnet.subnet_main : subnet.name => subnet.id }
} 

# output "subnet_ids_simple" {
#   value = var.subnet_type == "simple" ? azurerm_subnet.simple_subnets.*.id : []
# } 

output "nat_gateway_ids" {
  value = {
    for subnet_key, nat_gateway in azurerm_nat_gateway.nat :
    subnet_key => nat_gateway.id
  }
} 