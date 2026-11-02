terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "opentofu/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_ecr_repository" "app_repo" {
  name                 = "secure-shop-repo"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}