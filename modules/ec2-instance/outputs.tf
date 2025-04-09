output "aws_instance_id" {
  value = aws_instance.tfe_instance.id
}

output "aws_instance_public_ip" {
  value = aws_instance.tfe_instance.public_ip
}

output "ec2_instance_public_dns" {
  value       = aws_instance.tfe_instance.public_dns
  description = "The public DNS of the EC2 instance"
}

output "tfe_instance_public_ip" {
  description = "The public IP address of the Terraform Enterprise instance."
  value       = aws_instance.tfe_instance.public_ip
}