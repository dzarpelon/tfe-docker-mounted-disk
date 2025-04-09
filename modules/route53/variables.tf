variable "route53_zone_id" {
  description = "The ID of the Route 53 hosted zone."
  type        = string
}

variable "route53_zone_name" {
  description = "The name of the Route 53 hosted zone."
  type        = string
}

variable "tfe_instance_public_ip" {
  description = "The public IP address of the Terraform Enterprise instance."
  type        = string
}

variable "aws_instance_name" {
  description = "Name tag for the EC2 instance."
  type        = string
}