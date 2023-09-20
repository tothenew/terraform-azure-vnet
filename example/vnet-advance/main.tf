provider "azurerm" {
  features {}
}

## Users can create the resource group here 
resource "azurerm_resource_group" "main" {
  name     = "my-vnet-rg1"
  location = "eastus"
}

module "vnet_main" {
  source              = "git::https://github.com/tothenew/terraform-azure-vnet.git"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  address_space       = "10.0.0.0/16"

  virtual_network_peering = false

  subnets = {
    "vm1" = {
      address_prefixes           = ["10.0.1.0/24"]
      associate_with_route_table = true
      is_natgateway              = true
      is_nsg                     = true
      service_delegation         = true
      delegation_name            = "Microsoft.ContainerInstance/containerGroups"
      delegation_actions         = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
    "vm2" = {
      address_prefixes           = ["10.0.2.0/24"]
      associate_with_route_table = false
      service_endpoints          = ["Microsoft.AzureCosmosDB"]
    }
  }
} 