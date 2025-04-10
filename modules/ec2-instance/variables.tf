variable "aws_ami" {
  type = string
}

variable "aws_instance_type" {
  type = string
}

variable "aws_owner" {
  type = string
}

variable "aws_instance_name" {
  type = string
}

variable "user_data" {
  description = "The cloud-init user_data for the EC2 instance."
  type        = string
}

variable "disk_size" {
  description = "The size of the root EBS volume in GiB."
  type        = number
}

variable "disk_type" {
  description = "the AWS disk type to be used on this instance"
  type        = string
  default     = "gp3"
}

variable "vpc_security_group_ids" {
  description = "List of security group IDs to associate with the instance."
  type        = list(string)
  default     = []
}

variable "tfe_license" {
  description = "Terraform Enterprise license."
  type        = string
  sensitive   = true
}

variable "tfe_version" {
  description = "The version of Terraform Enterprise to deploy."
  type        = string
}

variable "certbot_email" {
  description = "Email used for certbot notifications."
  type        = string
}

variable "route53_zone_name" {
  description = "The name of the Route 53 hosted zone."
  type        = string
}

variable "encryption_password" {
  description = "The encryption password for Terraform Enterprise."
  type        = string
  sensitive   = true
}

variable "initial_user_password" {
  description = "The password for the initial admin user."
  type        = string
  sensitive   = true
}