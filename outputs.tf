output "tfe_url" {
  description = "The URL of the Terraform Enterprise system that will be used to access it"
  value = "Use the following URL to access TFE: https://${var.aws_instance_name}.${var.route53_zone_name}"
}
output "initial_admin_user_creation_status" {
  description = "The status of the initial admin user creation. Check the /var/log/cloud-init-output.log file on the instance for details."
  value       = "Check the /var/log/cloud-init-output.log file on the instance for the result of the user creation process."
}
output "deploy_waiting_time" {
  description = "Inform that the system needs about 5 minutes to complete full installation"
  value = "please allow about 5 minutes until the system is fully up and running"
}