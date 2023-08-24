resource "azurerm_network_security_group" "main" {
  for_each            = { for k, v in var.subnets : k => v if v.is_nsg }
  name                = "${each.key}-nsg"
  resource_group_name = var.resource_group_name
  location            = var.location

  tags = merge(var.default_tags, var.common_tags, tomap({
    "Name" : "${var.name_prefix}"
  }))
}

resource "azurerm_subnet_network_security_group_association" "subnet_nsg_association" {
  for_each                  = { for k, v in var.subnets : k => v if v.is_nsg }
  subnet_id                 = azurerm_subnet.subnet_main[each.key].id
  network_security_group_id = azurerm_network_security_group.main[each.key].id

  depends_on = [azurerm_network_security_group.main]
} 