resource "aws_instance" "myEc2" {
  count                = var.vpc_create ? var.instance_count : 1
  ami                  = var.ami_value
  instance_type        = var.instance_size
  subnet_id            = var.vpc_create ? aws_subnet.public-subnet[0].id : null
  key_name             = var.key_name
  availability_zone    = var.vpc_create ? element(var.a_z, count.index) : null
  vpc_security_group_ids = var.vpc_create ? [aws_security_group.my_sg[0].id] : null

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/.ssh/id_rsa")
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = ["sudo apt update && sudo apt install nginx -y"]
  }
}

resource "aws_key_pair" "myKeypair" {
  key_name   = "krupakar"
  public_key = file("~/.ssh/id_rsa.pub")
}
