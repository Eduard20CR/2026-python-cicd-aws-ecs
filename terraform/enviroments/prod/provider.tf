terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "terraform"

  default_tags {
    tags = {
      ManagedBy   = "terraform"
      Environment = "production"
      Practice    = "2026-python-cicd-aws-ecs"
    }
  }
}
