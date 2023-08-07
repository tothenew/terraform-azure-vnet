output "nsg_ids" {
  value = {
    for subnet_key, nsg in azurerm_network_security_group.main :
    subnet_key => nsg.id 
  }
} 

