resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.vpc-dev.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat[0].id
  }
  tags = {
    "Name" = "private_rt-${var.Environment}"
  }
}
resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.vpc-dev.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    "Name" = "public_rt-${var.Environment}"
  }
}

resource "aws_route_table_association" "private" {
  count = length(var.private_cidr)
  subnet_id = element(aws_subnet.private-subnets[*].id, count.index)
  route_table_id = aws_route_table.private-rt.id
}

resource "aws_route_table_association" "public" {
  count = length(var.public_cidr)
  subnet_id = element(aws_subnet.public-subnet[*].id, count.index)
  route_table_id = aws_route_table.public-rt.id
}
