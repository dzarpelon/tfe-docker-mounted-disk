output "aws_instance_id" {
  value = aws_instance.tfe_instance.id
}

output "aws_instance_public_ip" {
  value = aws_instance.tfe_instance.public_ip
}