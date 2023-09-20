resource "azurerm_virtual_network" "main" {
  name                = var.vnet_name
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = [var.address_space]

  tags = merge(var.default_tags, var.common_tags, tomap({
    "Name" : var.name_prefix
  }))
}

## VIRTUAL NETWORK PEERING ..............##

resource "azurerm_virtual_network_peering" "peering" {
  count                        = var.virtual_network_peering ? 1 : 0
  name                         = var.vnet_peering_name
  resource_group_name          = var.resource_group_name
  virtual_network_name         = azurerm_virtual_network.main.name
  remote_virtual_network_id    = azurerm_virtual_network.main.id
  allow_virtual_network_access = var.allow_virtual_network_access
  allow_forwarded_traffic      = var.allow_forwarded_traffic

  # `allow_gateway_transit` must be set to false for vnet Global Peering
  allow_gateway_transit = var.allow_gateway_transit
}
