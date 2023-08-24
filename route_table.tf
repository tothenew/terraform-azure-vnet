resource "azurerm_route_table" "main" {
  count               = local.create_route_table != [] ? 1 : 0
  name                = var.route_table_name
  resource_group_name = var.resource_group_name
  location            = var.location

  # Define routes for the public route table, including the default route pointing to the Internet Gateway 
  # route {
  #   name                   = "default-route"
  #   address_prefix         = "0.0.0.0/0"
  #   next_hop_type          = "Internet"
  # }
}

resource "azurerm_subnet_route_table_association" "subnet_route_table_association" {
  for_each       = { for k, v in var.subnets : k => v if v.associate_with_route_table == true }
  subnet_id      = azurerm_subnet.subnet_main[each.key].id
  route_table_id = azurerm_route_table.main[0].id

  depends_on = [azurerm_subnet.subnet_main, azurerm_route_table.main]
} 