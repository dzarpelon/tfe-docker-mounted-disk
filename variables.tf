variable "aws_region" {
  description = "The AWS region."
  type        = string
}

variable "aws_credentials_profile" {
  description = "The AWS CLI profile to use."
  type        = string
}

variable "aws_ami" {
  description = "The AMI for the EC2 instance."
  type        = string
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

variable "certbot_email" {
  description = "Email used for certbot notifications"
  type        = string
}