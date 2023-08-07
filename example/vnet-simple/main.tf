provider "azurerm" {
  features {}
}

module "vnet_main" {
  #source = "git::https://github.com/DeepakBoora/terraform-azure-vnet.git"
  source = "../.."
  address_space  = "10.0.0.0/16"
  subnet_type = "subnet_simple" 
  subnet_bits = 3 
  subnets = { } 
}

