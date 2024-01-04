resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc-dev.id
  tags = {
    Name = "igw-${var.Environment}"
  }
}