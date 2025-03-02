resource "aws_instance" "tfe-fdo-docker-mounted" {
  ami                    = var.aws_ami
  instance_type          = var.aws_instance_type
  // user_data              = file("${path.module}/data/cloudinit.tpl")

  tags = {
    Name  = var.aws_instance_name,
    owner = var.aws_owner
  }
}
