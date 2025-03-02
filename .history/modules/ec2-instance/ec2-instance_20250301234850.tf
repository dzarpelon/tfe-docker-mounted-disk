resource "aws_instance" "tfe-fdo-docker-mounted" {
  ami                    = var.aws_ami
  instance_type          = var.aws_instance_type

  tags = {
    Name = "${var.aws_instance_name}-${substr(md5(timestamp()), 0, 6)}" ,
    owner = var.aws_owner
    }
  }