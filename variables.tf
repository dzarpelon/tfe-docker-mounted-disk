## Setup AWS related variables
variable "aws_region" {
  description = "The AWS region used for deployment"
  type        = string
  default     = "eu-central-1"
}

variable "aws_credentials_profile" {
  description = "The AWS profile credentials to be used. This will come from your ~/.aws/credentials file"
  type        = string
  default     = "default" //this set the "default" profile of you ~/.aws/credentials file. 
}

# EC2 module variables
variable "aws_ami" {
  description = "The ami to be used with this system. Remember that AMI values differ depending on the region it will be deployed. Default value is for Ubuntu24.04LTS  from eu-central"
  type        = string
  default     = "ami-07eef52105e8a2059" # AMI ID for Ubuntu 24.04 LTS in eu-central-1. 
}

variable "aws_instance_type" {
  description = "Define which AWS instance type will be used. Default to free tier"
  type        = string
  default     = "t3.medium" //used for cost purposes, to meet the requirements use "t3.xlarge"
}
variable "aws_owner" {
  description = "Set owner name to use on tag"
  type        = string
}

variable "aws_instance_name" {
  description = "The name to be used for the the ec2 instance"
  type        = string
}

