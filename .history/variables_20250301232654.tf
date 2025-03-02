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
