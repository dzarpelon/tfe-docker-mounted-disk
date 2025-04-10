output "initial_admin_user_creation_status" {
  description = "The status of the initial admin user creation. Check the /var/log/cloud-init-output.log file on the instance for details."
  value       = "Check the /var/log/cloud-init-output.log file on the instance for the result of the user creation process."
}