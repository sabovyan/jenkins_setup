resource "local_file" "example" {
  content = templatefile("./templates/inventory.tftpl", {
    hosts = [aws_instance.Jenkins.public_ip]
  })
  filename = "../ansible/inventory"

  depends_on = [
    aws_instance.Jenkins
  ]

}

resource "local_file" "jenkins_public_key" {
  content         = tls_private_key.key_pair.private_key_pem
  filename        = "../../${var.ssh_key_name}.pem"
  file_permission = "0400"
}