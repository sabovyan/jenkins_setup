variable "ssh_key_name" {
  type    = string
  default = "jenkins_ssh_key"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "aws_region" {
  type    = string
  default = "us-east-1"
}