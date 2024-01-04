### EC2 Module with-in (or) without VPC
This is a ec2 module to spin up instance in default or seperate VPC.

## Usage

## with-out VPC (ec2 launches in default vpc)

```sh


provider "aws" {
  region = "ap-south-1"
}

module "ec2" {
    source = "git::https://github.com/krupakar0307/infra-modules.git//ec2"
    region = "ap-south-1"
    vpc_create = false # if need ec2 in own vpc, disable it.
    vpc_cidr = ""
    vpc_name = ""
    Environment = ""
    a_z = [""]
    public_cidr = [""]
    ami_value = "ami-0a11b74e4c74e3790"
    instance_size = "t2.micro"
    instance_count = "2"
    key_name = "keyName" 
}

```

## with in VPC

#### Enable vpc_create = true

```sh

provider "aws" {
  region = "ap-south-1"
}

module "ec2" {
    source = "git::https://github.com/krupakar0307/infra-modules.git//ec2"
    region = "ap-south-1"
    vpc_create = true # if need ec2 in own vpc, disable it.
    vpc_cidr = "10.0.0.0/16"
    vpc_name = "vpc-dev"
    Environment = "dev"
    a_z = [ "ap-south-1a" ]
    public_cidr = [ "10.0.1.0/24"]
    ami_value = "ami-0a11b74e4c74e3790"
    instance_size = "t2.micro"
    instance_count = "2"
    key_name = "key_name" 
}

When VPC is false, put empty string for vpc input variables.

```
