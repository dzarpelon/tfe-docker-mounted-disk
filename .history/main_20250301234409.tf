// configure aws provider
provider "aws" {
  region  = var.aws_region
  profile = var.aws_credentials_profile
}

// import the modules

module "ec2-instance" {
  source    = "./modules/ec2-instance/"
  aws_owner = var.aws_owner
  aws_ami = var.aws_ami
  aws_instance_type = var.aws_instance_type
  aws_instance_name ="${var.aws_instance_name}-${substr(md5(timestamp()), 0, 6)}"
}