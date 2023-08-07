provider "azurerm" {
  features {}
}

module "vnet_main" {
  source = "git::https://github.com/tothenew/terraform-azure-vnet.git?ref=vnet-v1"
  address_space     = "10.0.0.0/16"  
  subnets = {
     "vm1" = {
      address_prefixes = ["10.0.1.0/24"]
      associate_with_route_table = true   
      is_natgateway = true 
      is_nsg = true 
      network_security_group_association = {
      security_rules = [
        {
          name                       = "Rule1"
          priority                   = 100
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = "80"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        }
       ]
      } 
    }   
    "vm2" = {
    address_prefixes = ["10.0.2.0/24"]
    associate_with_route_table = false    
    } 
  }
}
 
