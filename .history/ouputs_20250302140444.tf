output "aws_instance_id" {
    description = "The ID of the EC2 instance"
    value       = module.ec2-instance.aws_instance_id
}