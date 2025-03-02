output "aws_instance_id" {
    description = "The ID of the EC2 instance"
    value       = module.ec2-instance.aws_instance_id
}

output "aws_instance_external_ip" {
  description = "The external IP of this AWS instance"
  value = module.ec2-instance.aws_instance_external_ip
}