output "instance_pub_ip" {
    value = aws_instance.myEc2[*].public_ip
}
