variable "security_group_name" {
  description = "The name of the security group."
  type        = string
  default     = "tfe-security-group"
}

variable "security_group_description" {
  description = "The description of the security group."
  type        = string
  default     = "Security group for Terraform Enterprise instance"
}