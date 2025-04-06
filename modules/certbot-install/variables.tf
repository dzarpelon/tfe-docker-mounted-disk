variable "certbot_email" {
  description = "Email address for Certbot registration."
  type        = string
}

variable "instance_public_dns" {
  description = "The public DNS of the EC2 instance"
  type        = string
}