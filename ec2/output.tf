output "my_output" {
    value = aws_instance.myEc2[*].public_ip
}
