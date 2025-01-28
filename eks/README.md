### EKS setup.

This repo consists of resources for eks infra. and this is in developing stage. we have other open source modues in the repository 
(terraform-eks-mode)

As on data (Dec-2023), this module eks is able to provison eks managed nodes with BOttleRocket nodes. you can increase or launch specific template from module files. (.terraform files)

### Usage:

```sh 

provider "aws" {
  region = "ap-south-1"
}

module "eks" {
  source = "git::https://github.com/krupakar0307/infra-modules.git//eks"

  vpc_cidr = "10.0.0.0/16"
  vpc_name = "dev"
  Environment = "development"
  private_cidr =[ "10.0.1.0/24","10.0.2.0/24" ]
  a_z  = [ "ap-south-1a","ap-south-1b" ]
  public_cidr = [ "10.0.3.0/24","10.0.4.0/24" ]

  ##Provide EKS speicifications

  eks_name = "eks-demo"
  cluster_version = 1.32

  ##Node Specitifiactions

  instance_type = "t3.medium"
  scaling_config = {
    min_size = 1
    max_size = 2
    desired_size = 1
  }

}
```

 ##### Yet in this module in future, we'll add automated autoscaler deployment, IAM enable for the cluster.
