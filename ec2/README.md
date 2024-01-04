### EC2 Module with-in (or) without VPC
This is a ec2 module to spin up instance in default or seperate VPC.

## Usage

## with-out VPC (ec2 launches in default vpc)

```sh
module "ec2" {
    source = "git::h"
    region = 
    vpc_create = false # if need ec2 in own vpc, enable it.
    ami_value = ""
    instance_size = ""
    instance_count = ""
    key_name = "" 
}

```

## with in VPC

#### Enable vpc_create = true

```sh

module "ec2" {
    source = "git::h"
    region = "ap-south-1"

    vpc_create = true # if need ec2 in own vpc, disable it.
    vpc_cidr = "10.0.0.0/16"
    vpc_name = "vpc-dev"
    Environment = ""
    a_z = ""
    public_cidr = ""


    ami_value = ""
    instance_size = ""
    instance_count = ""
    key_name = "" 

}

```
