terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "3.1.0"
    }
    backend "remote" {
      organization = "Terraform-CI-CD"

      workspaces {
        name = "Desafio"
      }
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}
