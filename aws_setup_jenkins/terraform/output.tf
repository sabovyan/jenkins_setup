output "instance_public_ip" {
  value = aws_instance.Jenkins.public_ip
}

# TODO replace public id with dns
output "dns" {
  value = aws_instance.Jenkins.public_dns
}
