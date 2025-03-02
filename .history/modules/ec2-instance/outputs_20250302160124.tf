output "aws_instance_id" {
    description = "The ID of the EC2 instance"
    value       = aws_instance.tfe-fdo-docker-mounted.id
}

output "aws_instance_external_ip" {
    description = "The external IP of this AWS instance"
    value = aws_instance.tfe-fdo-docker-mounted.public_ip
}

output "aws_instance_external_dns" {
    description = "The external DNS of this AWS instance"
    value = aws_instance.tfe-fdo-docker-mounted.public_dns
}