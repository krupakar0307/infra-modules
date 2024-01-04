variable "region" {
#   default = "us-east-1"
  description = "Provide Region"
}



#######
#######
#Do you wanna create VPC for your EC2? if yes, vpc_create=true and provide cidr range inputs for vpc nd subnet.
######
#######
variable "vpc_create" {
  type = bool
#   default = false
}

#####
variable "vpc_cidr" {
  type = string
#   default = "10.0.0.0/16"
}
variable "vpc_name" {
  type = string
#   default = "vpc-dev"
}
variable "Environment" {
  type = string
#   default = "Dev"
}

variable "a_z" {
  type = list(string)
  description = "Provide az's"
#   default = [ "ap-south-1a","ap-south-1b" ]
}

variable "public_cidr" {
  type = list(string)
  description = "Provide public subnet cidr range"
#   default = [ "10.0.1.0/24"]
}

######################
##EC2 Configuration###
######################

# EC2 instance vars

variable "ami_value" {
    # default = "ami-0a11b74e4c74e3790"
}
variable "instance_size" {
    # default = "t2.micro"
}
variable "key_name" {
    # default = "krupakar"
}
variable "instance_count" {
  default = "1"
#   description = "No. of instances"
}