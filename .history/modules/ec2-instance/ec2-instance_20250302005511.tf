resource "aws_instance" "tfe-fdo-docker-mounted" {
  ami           = var.aws_ami
  instance_type = var.aws_instance_type
  user_data     = file("${path.module}/data/cloudinit.tpl")

  tags = {
    Name  = var.aws_instance_name,
    owner = var.aws_owner
  }
    connection {
    type = "ssh"
    user = "ubuntu"
    host = self.public_ip
  }
}

// temporary SSH connection for testing purposes

resource "aws_security_group" "temp_allow_ssh" {
  name        = "allow_ssh"
  description = "Security group to allow inbound SSH traffic"

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
  