module "ssm" {
  source            = "../ssm"
  aws_instance_name = var.aws_instance_name
}

resource "aws_instance" "tfe_instance" {
  ami                    = var.aws_ami
  instance_type          = var.aws_instance_type
  user_data              = var.user_data
  vpc_security_group_ids = var.vpc_security_group_ids
  tags = {
    Name  = var.aws_instance_name
    owner = var.aws_owner
  }
  iam_instance_profile = module.ssm.ssm_instance_profile
  root_block_device {
    volume_size = var.disk_size
    volume_type = var.disk_type
  }
}

