terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.52.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

data "aws_ami" "ubuntu" {

  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "Jenkins" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.sg_jenkins.id]

  key_name = aws_key_pair.jenkins_key.key_name

  tags = {
    Name  = "Jenkins"
    group = "Jenkins"
  }
}

resource "aws_instance" "App" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.sg_jenkins.id]

  key_name = aws_key_pair.jenkins_key.key_name

  tags = {
    Name  = "main_app"
    group = "main_app"
  }
}


resource "aws_security_group" "sg_jenkins" {
  name        = "sg_jenkins"
  description = "Allow HTTP and SSH traffic via Terraform"

  tags = {
    "group" = "Jenkins"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # TODO = security issue with incoming 0.0.0.0/0
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


