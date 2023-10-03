terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.16.1"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~>4.0.4"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "~>3.20.1"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

provider "tls" {}

# provider "vault" {}