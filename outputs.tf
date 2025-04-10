output "initial_admin_user" {
  description = "The username of the initial admin user."
  value       = "admin"
}

output "initial_admin_password" {
  description = "The password of the initial admin user."
  value       = var.initial_user_password
  sensitive = true
}

output "initial_admin_user_creation_status" {
  description = "The status of the initial admin user creation. Check the /var/log/cloud-init-output.log file on the instance for details."
  value       = "Check the /var/log/cloud-init-output.log file on the instance for the result of the user creation process."
}