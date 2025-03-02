data "aws_ami" "ubuntu_lts" {
  most_recent = true
  owners      = ["099720109477"] # Canonical's owner ID

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-lts-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}