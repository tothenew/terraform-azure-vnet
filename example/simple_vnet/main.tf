provider "azurerm" {
  features {}
}

module "simple-vnet" {
  source = "git::https://github.com/tothenew/terraform-azure-vnet.git"
  vnet_cidr_block = "10.0.0.0/16"
  subnet_type = "simple"
  num_simple_subnets = 2 
  resource_group_name = "my-resource-group"
  location            = "eastus"
  subnets = { } 
}
