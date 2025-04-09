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

variable "vpc_security_group_ids" {
  description = "List of security group IDs to associate with the instance."
  type        = list(string)
  default     = []
}