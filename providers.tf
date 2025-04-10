terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.89"
    }
  }
}

provider "aws" {
  region = var.aws_region

  # Use credentials file if aws_credentials_type is "profile"
  profile = var.aws_credentials_type == "profile" ? var.aws_credentials_profile : null

  # Use environment variables if aws_credentials_type is "env"
  access_key = var.aws_credentials_type == "env" ? var.AWS_ACCESS_KEY_ID : null
  secret_key = var.aws_credentials_type == "env" ? var.AWS_SECRET_ACCESS_KEY : null
  token      = var.aws_credentials_type == "env" ? var.AWS_SESSION_TOKEN : null
}