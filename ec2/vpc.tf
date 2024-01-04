resource "aws_vpc" "vpc-dev" {
  cidr_block = var.vpc_cidr
  count      = var.vpc_create ? 1 : 0
  tags       = {
    Name        = var.vpc_name
    Environment = var.Environment
  }
}

### create igw

resource "aws_internet_gateway" "igw" {
  count = var.vpc_create ? 1 : 0
  vpc_id = aws_vpc.vpc-dev[0].id
  tags = {
    Name = "igw-${var.Environment}"
  }
}

### create subnets (Public)

resource "aws_subnet" "public-subnet" {
  count             = var.vpc_create ? length(var.public_cidr) : 0 #ternary condition to set/evaluate the vpc enabled or not.
  vpc_id            = aws_vpc.vpc-dev[0].id
  cidr_block        = element(var.public_cidr, count.index)
  availability_zone = element(var.a_z, count.index)
  map_public_ip_on_launch = true
}

# #### create routes.

resource "aws_route_table" "public-rt" {
  count = var.vpc_create ? 1 : 0
  vpc_id = aws_vpc.vpc-dev[0].id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw[0].id
  }
  tags = {
    "Name" = "public_rt-${var.Environment}"
  }
}

resource "aws_route_table_association" "public" {
  count          = var.vpc_create ? length(var.public_cidr) : 0
  subnet_id      = element(aws_subnet.public-subnet[*].id, count.index)
  route_table_id = aws_route_table.public-rt[0].id
}
