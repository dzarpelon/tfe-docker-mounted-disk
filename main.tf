
// import the modules

module "ec2-instance" {
  source            = "./modules/ec2-instance/"
  aws_ami           = var.aws_ami
  aws_instance_type = var.aws_instance_type
  aws_owner         = var.aws_owner
  aws_instance_name = var.aws_instance_name
  user_data         = module.docker-install.docker_install_snippet
}

module "docker-install" {
  source = "./modules/docker-install"
  //depends_on = [module.ec2-instance] // Ensures EC2 is created first
}