resource "aws_eip" "eip" {
  domain = "vpc"
  tags = {
    "Name" = "eip_${var.Environment}"
  }
}
resource "aws_nat_gateway" "nat" {
  count = 1
  allocation_id = aws_eip.eip.id
  subnet_id = element(aws_subnet.public-subnet[*].id, 0)
  tags = {
    "Name" = "nat-dev"
  }
}
