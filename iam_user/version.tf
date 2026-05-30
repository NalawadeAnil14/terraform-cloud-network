terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.28"
    }
  }

 cloud {
    
    organization = "ABN-first-org"

    workspaces {
      name = "CLI-driven-workspace"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}
