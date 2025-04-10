module "ssm" {
  source            = "../ssm"
  aws_instance_name = var.aws_instance_name
}

data "cloudinit_config" "merged_config" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/cloud-config"
    content = templatefile("${path.module}/cloud-init.tpl", {
      tfe_license         = var.tfe_license,
      tfe_version         = var.tfe_version,
      certbot_email       = var.certbot_email,
      tfe_hostname        = "${var.aws_instance_name}.${var.route53_zone_name}",
      encryption_password = var.encryption_password,
      aws_instance_name   = var.aws_instance_name,
      route53_zone_name   = var.route53_zone_name,
      initial_user_password = var.initial_user_password
    })
  }
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

