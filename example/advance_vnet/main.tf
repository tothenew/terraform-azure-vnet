provider "azurerm" {
  features {}
}

module "advance-vnet" {
  source = "git::https://github.com/tothenew/terraform-azure-vnet.git?ref=vnet-v1"
  vnet_cidr_block = "10.0.0.0/16"
  subnet_type = "advance"
  num_simple_subnets = 0 
  resource_group_name = "my-resource-group"
  location            = "eastus"
  subnets = {
  "subnet1" = {
    cidr_block = "10.0.1.0/24"
    is_public  = true
  }
  "subnet2" = {
    cidr_block = "10.0.2.0/24"
    is_public  = true  
  }
}
}
 
