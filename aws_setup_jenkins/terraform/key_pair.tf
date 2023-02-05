resource "tls_private_key" "key_pair" {
  algorithm = "RSA"
}

resource "aws_key_pair" "jenkins_key" {
  key_name   = var.ssh_key_name
  public_key = tls_private_key.key_pair.public_key_openssh
}

resource "local_file" "jenkins_public_key" {
  content         = tls_private_key.key_pair.private_key_pem
  filename        = "../../${var.ssh_key_name}.pem"
  file_permission = "0400"
}
