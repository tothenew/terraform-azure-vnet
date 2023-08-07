# resource "azurerm_network_security_group" "main" {
#   name                = var.nsg_name
#   location            = var.location
#   resource_group_name = var.resource_group_name
# }

resource "azurerm_network_security_group" "main" {
  for_each = { for k, v in var.subnets : k => v if v.is_nsg } 
  name                = "${each.key}-nsg" 
  resource_group_name = var.resource_group_name
  location            = var.location

  tags = merge(var.default_tags, var.common_tags ,  tomap({
    "Name" : "${var.name_prefix}"
  })) 
}   