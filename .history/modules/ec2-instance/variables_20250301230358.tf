variable "ami" {
    description = "The ami to be used with this system. Remember that AMI values differ depending on the region it will be deployed. Default value is for Ubuntu24.04LTS  from eu-central"
    type        = string
    default     = "ami-07eef52105e8a2059" # AMI ID for Ubuntu 24.04 LTS in eu-central-1. 
}

variable "instance_type" {
  description = "Define which AWS instance type will be used. Default to free tier"
  type        = string
  default     = "t3.micro" # This is NOT the minimum accepted by TFE.
}
