# output "nsg_id" {
#   value = azurerm_network_security_group.main.id
# }

output "nsg_ids" {
  value = {
    for subnet_key, nsg in azurerm_network_security_group.main :
    subnet_key => nsg.id 
  }
} 

