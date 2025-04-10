variable "aws_region" {
  description = "The AWS region."
  type        = string
}

variable "aws_credentials_profile" {
  description = "The AWS CLI profile to use."
  type        = string
  default     = "default"
}

variable "aws_credentials_type" {
  description = "The type of AWS credentials to use: 'profile' or 'env'."
  type        = string
  default     = "profile"
}

variable "aws_ami" {
  description = "The AMI for the EC2 instance."
  type        = string
  default     = "ami-07eef52105e8a2059" # Ubuntu 24.04
}

variable "aws_instance_type" {
  description = "The EC2 instance type."
  type        = string
}

variable "aws_owner" {
  description = "Owner tag for the instance."
  type        = string
}

variable "aws_instance_name" {
  description = "Name tag for the EC2 instance."
  type        = string
}

variable "tfe_license" {
  description = "Terraform Enterprise license. This must be set via an environment variable (e.g., TF_VAR_tfe_license)."
  type        = string
  sensitive   = true

}

variable "tfe_version" {
  description = "The version of Terraform Enterprise to deploy."
  type        = string
}

variable "disk_size" {
  description = "The size of the root EBS volume in GiB."
  type        = number
  default     = 80
}

variable "route53_zone_id" {
  description = "The ID of the Route 53 hosted zone."
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

variable "disk_type" {
  description = "the AWS disk type to be used on this instance"
  type        = string
  default     = "gp3"
}

variable "initial_user_password" {
  description = "The password for the initial admin user."
  type        = string
  sensitive   = true
}

variable "AWS_ACCESS_KEY_ID" {
  description = "AWS Access Key ID for environment variable authentication."
  type        = string
  sensitive   = true
  default     = null
}

variable "AWS_SECRET_ACCESS_KEY" {
  description = "AWS Secret Access Key for environment variable authentication."
  type        = string
  sensitive   = true
  default     = null
}

variable "AWS_SESSION_TOKEN" {
  description = "AWS Session Token for environment variable authentication (optional)."
  type        = string
  sensitive   = true
  default     = null
}