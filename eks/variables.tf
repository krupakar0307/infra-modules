variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
}
variable "vpc_name" {
  type = string
  default = "vpc-dev"
}
variable "Environment" {
  type = string
  default = "Dev"
}
variable "private_cidr" {
  type = list(string)
  description = "Provide private subnet cidr range"
  default = [ "10.0.1.0/24","10.0.2.0/24" ]
}

variable "a_z" {
  type = list(string)
  description = "Provide az's"
  default = [ "ap-south-1a","ap-south-1b" ]
}

variable "public_cidr" {
  type = list(string)
  description = "Provide public subnet cidr range"
  default = [ "10.0.3.0/24","10.0.4.0/24" ]
}

######################################################
### EKS#######
######################################################
variable "eks_name" {
  type = string
  description = "Provide EKS Name"
  default = "demo"
}
variable "cluster_version" {
  description = "Prvide EkS cluster version"
  type = number
  default = 1.27
}

#####
#NODE SPECS.
#####


variable "node_capacity" {
  type = string
  default = "ON_DEMAND"
}
variable "instance_type" {
  default = "t3.medium"
  type = string
}
variable "ami_type" {
  default = "BOTTLEROCKET_x86_64"
  type = string
}
variable "scaling_config" {
  type = map(number)
  default = {
    "desired_size" = 1
    "max_size" = 3
    "min_size" = 0
  }
}
