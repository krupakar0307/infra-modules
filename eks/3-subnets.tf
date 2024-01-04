resource "aws_subnet" "private-subnets" {
  count = length(var.private_cidr)
  vpc_id = aws_vpc.vpc-dev.id
  cidr_block = element(var.private_cidr, count.index)
  availability_zone = element(var.a_z, count.index)
  tags = {
    "Name" = "private-subnet-${count.index+1}-${var.Environment}"
    "kubernetes.io/role/internal-elb" = "1"
  }
}

resource "aws_subnet" "public-subnet" {
  vpc_id = aws_vpc.vpc-dev.id
  count = length(var.public_cidr)
  cidr_block = element(var.public_cidr, count.index)
  availability_zone = element(var.a_z, count.index)
  map_public_ip_on_launch = true
  tags = {
    "Name" = "public-subnet-${count.index+1}-${var.Environment}"
    "kubernenets.io/role/elb" = "1"     
   }
}