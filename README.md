### This Repo. Consists consists couple of frequently using modules. 
#### VPC, EKS, EC2, Lambda, ... 
###### (yet some more modules going to be added in future based on usage and require.)

## 1. VPC Module:
Vpc having  private subnets and public subnets followd by route tables, IGT and NAT are used in this module.

### Usage:
Module usage: 

```sh
provider "aws" {
  region = ap-south-1
}

module "vpc" {
  source            =   "git::https://github.com/krupakar0307/infra-modules.git//vpc"
  region            =   "ap-south-1"
  vpc_name          =   "dev"
  vpc_cidr          =   "10.0.0.0/16"
  a_z               =   ["ap-south-1a", "ap-south-1b"]
  public_cidr       =   ["10.0.1.0/24", "10.0.2.0/24"]
  private_cidr      =   ["10.0.3.0/24", "10.0.4.0/24"]
}
```
Copy above module code and replace with your inputs.
Finally it will provision VPC with subnets and all.

VPC RESOUCE MAP after creation with above modular code:
[screenshot](vpc/assets/screenshot-1.png)

--------

## 2. EKS Module:

EKS provisioning with the module, it provisions eks-managed node-groups with BottleRocker AMI's. 
This EKS will provision in VPC, Seperate VPC will be created for this EKS.

### Usage:
Module usage:
```sh
provider "aws" {
  region = "ap-south-1"
}

module "eks" {
  source = "git::https://github.com/krupakar0307/infra-modules.git//eks"

  vpc_cidr = "10.0.0.0/16"
  vpc_name = "dev"
  Environment = "demo"
  private_cidr =[ "10.0.1.0/24","10.0.2.0/24" ]
  a_z  = [ "ap-south-1a","ap-south-1b" ]
  public_cidr = [ "10.0.3.0/24","10.0.4.0/24" ]
  eks_name = "demo"
  cluster_version = 1.27
  ###nodes conf.####
  node_capacity = "SPOT"
  instance_type = "t3.medium"
  ami_type = "BOTTLEROCKET_x86_64"
  scaling_config = {
      desired_size = 1
      max_size     = 3
      min_size     = 0
  }
}

```
Replace with your inputs in above eks modular code and use it.

- In this EKS module, will need to add RBAC and authentication process as well. (On hold...)


##### similarly for other modules and their usage as mentioned in their respective folder README's



=================================================================
