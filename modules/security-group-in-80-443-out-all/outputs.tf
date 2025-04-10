output "tfe_security_group_id" {
  description = "The ID of the security group."
  value       = aws_security_group.security-group-in-80-443-out-all.id
}