terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.52.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}


data "aws_ami" "amazon-linux-2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

}

resource "tls_private_key" "key_pair" {
  algorithm = "RSA"
}

resource "local_file" "jenkins_public_key" {
  content         = aws_key_pair.jenkins_key.public_key
  filename        = "../../jenkins.pem"
  file_permission = "0400"
}

resource "aws_key_pair" "jenkins_key" {
  key_name   = "jenkins_ssh_key"
  public_key = tls_private_key.key_pair.public_key_openssh
}

resource "aws_instance" "Jenkins" {
  ami = data.aws_ami.amazon-linux-2.id
  # TODO move t2 into variables
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.sg_jenkins.id]

  key_name = aws_key_pair.jenkins_key.key_name

  tags = {
    "Name" = "Jenkins"
  }
}






resource "aws_security_group" "sg_jenkins" {
  name        = "sg_jenkins"
  description = "Allow HTTP and SSH traffic via Terraform"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "instance_public_ip" {
  value = aws_instance.Jenkins.public_ip
}

# TODO replace public id with dns
output "dns" {
  value = aws_instance.Jenkins.public_dns
}

