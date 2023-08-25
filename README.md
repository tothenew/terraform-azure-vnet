# terraform-azure-vnet

[![Lint Status](https://github.com/tothenew/terraform-aws-template/workflows/Lint/badge.svg)](https://github.com/tothenew/terraform-aws-template/actions)
[![LICENSE](https://img.shields.io/github/license/tothenew/terraform-aws-template)](https://github.com/tothenew/terraform-aws-template/blob/master/LICENSE) 

This module creates the basic and advance network resources for virtual network in azure . 


## Prerequisites

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 | 

Before you begin, ensure you have the following installed:

- Terraform (version X.XX.X)
- Azure CLI (version X.XX.X)
- Azure Subscription

## Providers

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [azurerm](#requirement\_terraform) | >= 3.0 |

## Getting Started with Azure Virtual Network  

* This module contain the example child module which also contains the 2 sub modules i.e vnet-advance , vnet-simple
* vnet-advance module specifies the user defined subnet configuration in which the users create the advance configuration in vnet i.e subnet delegation service , nsg association , route table association , nat gateway etc.
* vnet-simple module specifies the simple configuration of virtual network i.e it will create only user define subnets and one virtual network.
    

This repository contains a Terraform module to create an Azure Virtual network.
 
### Configure Azure Provider

To configure the Azure provider, you need to set up the necessary Azure credentials. If you already have the Azure CLI installed and authenticated with Azure, Terraform will use the same credentials.

If you haven't authenticated with Azure, you can do so by running:

```bash
az login
```

### Clone the Repository

First, clone this repository to your local machine using the following command:

```bash
git clone <repository_url>
cd <repository_name>
```

### Initialize Terraform

Once you have cloned the repository, navigate to the module directory and initialize Terraform:

```bash
cd path/to/module_directory 
terraform init
```

This will download the necessary plugins required for Terraform to work with Azure.

### Apply the Terraform Configuration

After configuring the input variables, you can apply the Terraform configuration to create the Azure Container Registry:

```bash
terraform apply
```

Terraform will show you the changes that will be applied to the infrastructure. Type `yes` to confirm and apply the changes.


## Variables

The project uses the following variables:

- `location`: The Azure region where resources will be created.
- `resource_group_name`: The name of the resource group where resources will be provisioned.
- `vnet_name`: The name of the Virtual Network.
- `address_spae`: CIDR range for vnet. 
- `subnet_type`: The type of subnets to create.
- `subnets` : It defines the user defined subnet configuration
- `subnet_bits`: The number of simple subnets to create (used when `subnet_type = "subnet-simple"`). 
- `associate_with_route_table`: It create route table & associate the required subnet to route table.
- `is_natgateway`: If true then it create a nat gateway for the subnets.
- `is_nsg`: If true then it create a NSG for the subnets.
- `service_delegation`: If true then it will create the service delegation for subnet.
- `Virtual_network_peering`: If true then it will create the VNet Peering.

## Usage

To provision the resources, modify the variables in `variables.tf` to match your desired configuration.
```bash
module "vnet_main" {
  source = "git::https://github.com/tothenew/terraform-azure-vnet.git?ref=vnet-v1"
  resource_group_name = azurerm_resource_group.main.name
  location = azurerm_resource_group.main.location 
  address_space     = "10.0.0.0/16"  

  virtual_network_peering = true

  subnets = {
     "vm1" = {
      address_prefixes = ["10.0.1.0/24"]
      associate_with_route_table = false   
      is_natgateway = true 
      is_nsg = true 
      service_delegation = true
      delegation_name = "Microsoft.ContainerInstance/containerGroups"
      delegation_actions = ["Microsoft.Network/virtualNetworks/subnets/action"] 
    }   
    "vm2" = {
    address_prefixes = ["10.0.2.0/24"]
    associate_with_route_table = false  
    service_endpoints = ["Microsoft.AzureCosmosDB"]   
    } 
  }
}
```

## Resources

| Name | Type |
|------|------|
| [azurerm_virtual_network.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [azurerm_network_security_group.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_route_table.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route_table) | resource |
| [azurerm_subnet.subnets](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_subnet_route_table_association.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_route_table_association) | resource |
| [azurerm_subnet_network_security_group_association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |


## Inputs

| Name | Description | Type |
|------|-------------|------|
| <a name="subnet_type"></a> [subnet\_type](#subnet\_type) | define the type of the subnet for subnet_simple | string |
| <a name="address_space"></a> [address\_space](#address\_space) | specify the CIDR Block for vnet | string |
| <a name="address_prefixes"></a> [address\_prefixes](#address\_prefixes) | specify the CIDR Block for subnets in vnet | string |
| <a name="subnet_bits"></a> [subnet\_bits](#subnet\_bits) | define the number of subnet_simple creates | number |
| <a name="resource_group_name"></a> [resource\_group\_name](#resource\_group\_name) | specify the name of the resource group | string |
| <a name="location"></a> [location](#location) | specify the location of the vnet | string |
| <a name="subnets"></a> [subnets](#subnets) | specify the subnets name having cidr_ranges and is_public variable etc.. | <pre>map(object({<br>    is_public   = bool<br>    cidr_block  = string <br>    }))</pre> |
| <a name="virtual_network_peering"></a> [virtual\_network\_peering](#virtual\_network\_peering) | specify the creation of vnet peering. | bool |
| <a name="is_natgateway"></a> [is\_natgateway](#is\_natgateway) | specify the creation of NAT Gateway for subnets. | bool |
| <a name="is_nsg"></a> [is\_nsg](#is\_nsg) | specify the creation of NSG for subnets. | bool |
| <a name="service_delegation"></a> [service\_delegation](#service\_delegation) | specify the service_delegation for subnets. | bool |
| <a name="associate_with_route_table"></a> [associate\_with\_route\_table](#associate\_with\_route\_table) | specify the creation of Route Table and associate the subnets. | bool |
| <a name="service_endpoints"></a> [service\_endpoint](#service\_endpoint) | specify the service endpoint for subnets. | bool |

## Terraform Commands

Below are some useful Terraform commands for managing the project:

- `terraform init`: Initializes the Terraform configuration.
- `terraform validate`: To validate the syntax of the configuration.
- `terraform plan`: Shows the execution plan for the resources.
- `terraform apply`: Applies the changes and creates the Azure resources.
- `terraform destroy`: Destroys all resources created by Terraform.

## Authors

Module managed by [TO THE NEW Pvt. Ltd.](https://github.com/tothenew)

## License

Apache 2 Licensed. See [LICENSE](https://github.com/tothenew/terraform-azure-vnet/blob/main/LICENSE) for full details.  