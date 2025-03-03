terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = " ~> 5.89"
    }
    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = " ~> 2.3"
    }
  }
}

// configure aws provider
provider "aws" {
  region  = var.aws_region
  profile = var.aws_credentials_profile
}

provider "cloudinit" {
  # No special configuration needed unless desired.
}