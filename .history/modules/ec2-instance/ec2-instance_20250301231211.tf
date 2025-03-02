resource "aws_instance" "tfe-fdo-docker-mounted" {
  ami                    = var.ami
  instance_type          = var.instance_type
  }