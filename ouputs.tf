output "ec2_instance_public_ip" {
  value = module.ec2-instance.aws_instance_public_ip
}