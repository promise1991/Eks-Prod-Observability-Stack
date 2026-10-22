terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.70" # WHY? 5.x still has those blocks. v6 breaks old EKS module. Lock it.
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.12"
    }
  }
}
provider "aws" {
  region = var.aws_region
  # Why tags here? Production best practice - every resource gets these tags for cost tracking
  default_tags {
    tags = {
      Project     = "fitness-observability-lab"
      Environment = var.environment
      ManagedBy   = "terraform"
    }
  }
}