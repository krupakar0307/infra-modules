resource "aws_vpc" "vpc-dev" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_name
    Environment = var.Environment
  }
}