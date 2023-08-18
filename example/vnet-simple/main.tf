provider "azurerm" {
  features {}
}

## Users can create the resource group here 
resource "azurerm_resource_group" "main" {
  name     = "my-vnet-rg"
  location = "eastus" 
} 

module "vnet_main" {
  source = "git::https://github.com/tothenew/terraform-azure-vnet.git?ref=vnet-v1"
  resource_group_name = azurerm_resource_group.main.name
  location = azurerm_resource_group.main.location
  address_space  = "10.0.0.0/16"
  subnet_type = "subnet_simple" 
  subnet_bits = 3 
  subnets = { } 
}

