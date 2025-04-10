data "cloudinit_config" "merged_config" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/cloud-config"
    content = templatefile("${path.module}/modules/ec2-instance/cloud-init.tpl", {
      tfe_license           = var.tfe_license,
      tfe_version           = var.tfe_version,
      certbot_email         = var.certbot_email,
      tfe_hostname          = "${var.aws_instance_name}.${var.route53_zone_name}",
      encryption_password   = var.encryption_password,
      aws_instance_name     = var.aws_instance_name,
      route53_zone_name     = var.route53_zone_name,
      initial_user_password = var.initial_user_password
    })
  }
}

module "security_group" {
  source                     = "./modules/security-group-in-80-443-out-all/"
  security_group_name        = "tfe-security-group"
  security_group_description = "Security group for Terraform Enterprise instance"
}

module "ec2-instance" {
  source                 = "./modules/ec2-instance/"
  aws_ami                = var.aws_ami
  aws_instance_type      = var.aws_instance_type
  aws_owner              = var.aws_owner
  aws_instance_name      = var.aws_instance_name
  user_data              = data.cloudinit_config.merged_config.rendered
  disk_size              = var.disk_size
  disk_type              = var.disk_type
  vpc_security_group_ids = [module.security_group.tfe_security_group_id]
  tfe_license            = var.tfe_license
  tfe_version            = var.tfe_version
  encryption_password    = var.encryption_password
  certbot_email          = var.certbot_email
  initial_user_password  = var.initial_user_password
  route53_zone_name      = var.route53_zone_name
}

module "route53" {
  source                 = "./modules/route53/"
  route53_zone_id        = var.route53_zone_id
  route53_zone_name      = var.route53_zone_name
  aws_instance_name      = var.aws_instance_name
  tfe_instance_public_ip = module.ec2-instance.tfe_instance_public_ip
}