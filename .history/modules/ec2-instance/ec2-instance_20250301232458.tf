resource "aws_instance" "tfe-fdo-docker-mounted" {
  ami                    = var.aws_ami
  instance_type          = var.instance_type
  tags = {
    owner = var.aws_owner ,



  }
  }