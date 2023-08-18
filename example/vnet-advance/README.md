 ##  VNET-ADVANCE EXAMPLE

[![Lint Status](https://github.com/tothenew/terraform-azure-vnet/workflows/Lint/badge.svg)](https://github.com/tothenew/terraform-azure-vnet/actions)
[![LICENSE](https://img.shields.io/github/license/tothenew/terraform-azure-vnet)](https://github.com/tothenew/terraform-azure-vnet/blob/master/LICENSE)

This module creates the basic and advance network resources.

## Resource Created

* Azure Virtual Network
* Azure Route Table
* Azure Subnets
* Azure NSG

# Azure Subnet resource 

* In this vnet-advance module , user defined dynamic subnets are creating. 
* In the subnets block , users can define the following parameters :
  
  i) subnet_name : It is required to define the subnet name i.e here we specifies the subnet name like vm1 , vm2 etc..
  
  ii) address_prefexies : It is required to define the address_prefixes( subnet-cidr ) for every subnets.
  
  iii) is_natgateway : It is optional. If user want to create the NAT GATEWAY for any subnet then the user specifies is_natgateway parameter set to true.
     ```bash
      is_natgateway = true
     ``` 
  iv) is_nsg : It is optional. If user want to create the NSG for their subnet then it is manadetory to set to true for this parameter.
   ```bash
   is_nsg = true
   ``` 
  v) associate_with_route_table : It is required. As one route table will be create for sure. So if users want to associate any subnet with route table the the users specifies associate_with_route_table = true.
   ```bash
   associate_with_route_table = true
   ```
  vi) service_delegation : It is optional. If users want to create the delegation service for any subnet then they can set this parameter true. Along this parameter users choose the delegation_name and delegation_service parameter according to their use cases.
   ```bash
   service_delegation = true
   ``` 



## Prerequisites

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 | 

Before you begin, ensure you have the following installed:

- Terraform (version X.XX.X)
- Azure CLI (version X.XX.X)
- Azure Subscription

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

### Clean Up

To clean up the resources created by Terraform, you can use the `destroy` command:

```bash
terraform destroy
```

Terraform will show you the resources that will be destroyed. Type `yes` to confirm and destroy the resources.
```

