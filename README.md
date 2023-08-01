# terraform-azure-vnet

[![Lint Status](https://github.com/tothenew/terraform-azure-vnet/workflows/Lint/badge.svg)](https://github.com/tothenew/terraform-azure-vnet/actions)
[![LICENSE](https://img.shields.io/github/license/tothenew/terraform-azure-vnet)](https://github.com/tothenew/terraform-azure-vnet/blob/master/LICENSE)

This is a template to use for baseline. The default actions will provide updates for section bitween Requirements and Outputs.

The following content needed to be created and managed:
 - Introduction
     - Explaination of module 
     - Intended users
 - Resource created and managed by this module
 - Example Usages

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |

## Getting Started

Follow the steps below to get started with the project:

1. Clone this repository to your local machine.
2. Authenticate the Azure CLI with your Azure Subscription using `az login`.
3. Initialize Terraform by running `terraform init`.
4. If you want to create the simple subnet then choose the subnet_type = simple and specify the num_simple_subnets . 
5. If you want to create the advance subnet then choose the subnet_type = advance and specify the configuration of subnets variable and select num_simple_subnets = 0 . 

## Providers

No providers.

## Modules

| Name | Source |
|------|--------|
| <a name="nsg"></a> [nsg](#nsg) | ./modules/nsg |
| <a name="route_table"></a> [route\_table](#route\_table) | ./modules/route_table |
| <a name="subnets"></a> [subnets](#subnets) | .modules/subnets |
| <a name="vnet"></a> [vnet](#vnet) | ./modules/vnet |

## Resources

No resources.

## Terraform Commands

Below are some useful Terraform commands for managing the project:

- `terraform init`: Initializes the Terraform configuration.
- `terraform validate`: To validate the syntax of the configuration.
- `terraform plan`: Shows the execution plan for the resources.
- `terraform apply`: Applies the changes and creates the Azure resources.
- `terraform destroy`: Destroys all resources created by Terraform.

## Inputs

| Name | Description | Type |
|------|-------------|------|
| <a name="subnet_type"></a> [subnet\_type](#subnet\_type) | define the type of the subnet whether it is simple or advance | string |
| <a name="vnet_cidr_block"></a> [vnet\_cidr\_block](#vnet\_cidr\_block) | specify the CIDR Block for vnet | string |
| <a name="num_simple_subnets"></a> [num\_simple\_subnets](#num\_simple\_subnets) | define the number of simple subnets | number |
| <a name="resource_group_name"></a> [resource\_group\_name](#resource\_group\_name) | specify the name of the resource group | string |
| <a name="location"></a> [location](#location) | specify the location of the vnet | string |
| <a name="subnets"></a> [subnets](#subnets) | specify the subnets name for "advance" subnet_type having cidr_ranges and is_public variable | <pre>map(object({<br>    is_public   = bool<br>    cidr_block  = string <br>    }))</pre> |

## Outputs

No outputs.
<!-- END_TF_DOCS -->

## Authors

Module managed by [TO THE NEW Pvt. Ltd.](https://github.com/tothenew)

## License

Apache 2 Licensed. See [LICENSE](https://github.com/tothenew/terraform-azure-vnet/blob/main/LICENSE) for full details.