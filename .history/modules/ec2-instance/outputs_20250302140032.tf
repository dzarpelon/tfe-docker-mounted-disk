output "aws_instance_id" {
    description = "The ID of the EC2 instance"
    value       = aws_instance.tfe-fdo-docker-mounted.id
}