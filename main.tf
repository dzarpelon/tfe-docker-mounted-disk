// import the modules

data "cloudinit_config" "merged_config" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/cloud-config"
    content      = templatefile("${path.module}/modules/cloudinit/cloud-init.tpl", {
      tfe_license = var.tfe_license,
      tfe_version = var.tfe_version
    })
  }
}

module "ec2-instance" {
  source            = "./modules/ec2-instance/"
  aws_ami           = var.aws_ami
  aws_instance_type = var.aws_instance_type
  aws_owner         = var.aws_owner
  aws_instance_name = var.aws_instance_name
  user_data         = data.cloudinit_config.merged_config.rendered
  disk_size         = var.disk_size
}