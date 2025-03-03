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