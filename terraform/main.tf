terraform {
  required_providers {
    aws = {
      #version = ">= 1.0.4"
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = "us-east-2"
}