terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
  
  # OIDC authentication is handled automatically by Terraform Cloud
  # when TFC_AWS_PROVIDER_AUTH=true and other TFC_AWS_* environment variables are set
}