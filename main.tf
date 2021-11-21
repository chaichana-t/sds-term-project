terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.63"
    }

    cloundinit = {
      source  = "hashicorp/cloudinit"
      version = "2.2.0"
    }
  }
  required_version = ">=1.0"
}
