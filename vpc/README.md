### VPC_Module

This is a terraform code for vpc module. it will create public, private subnets, igw and ngw with routing.

I've provided module usage in below snippet. copy and replace with your required values and perform  terraform init, plan and apply.
## Usage

```sh

provider "aws" {
  region = ap-south-1
}

module "vpc" {
  source            =   "git::https://github.com/krupakar0307/terraform-module.git//vpc"
  region            =   "ap-south-1"
  vpc_name          =   "dev"
  vpc_cidr          =   "10.0.0.0/16"
  a_z               =   ["ap-south-1a", "ap-south-1b"]
  public_cidr       =   ["10.0.1.0/24", "10.0.2.0/24"]
  private_cidr      =   ["10.0.3.0/24", "10.0.4.0/24"]
}

```
Here you can see resource map diagram for vpc after provision with this module.

screenshot-1:

[screenshot-1](assets/screenshot-1.png)
[screenshot-2](assets/screenshot-2.png)



