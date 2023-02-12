resource "tls_private_key" "key_pair" {
  algorithm = "RSA"
}

resource "aws_key_pair" "jenkins_key" {
  key_name   = var.ssh_key_name
  public_key = tls_private_key.key_pair.public_key_openssh

  tags = {
    "group" = "Jenkins"
  }
}

