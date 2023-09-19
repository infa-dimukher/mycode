terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.16.1"
    }
	tls = {
      source = "hashicorp/tls"
      version = "4.0.4"
    }
  vault = {
      source = "hashicorp/vault"
      version = "3.20.1"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}


provider "tls" {}


provider "vault" {
  address = "http://54.162.226.10:8200"
  auth_login {
    path = "auth/aws/login"
    method = "aws"
    parameters = {
      role = "dev-role-iam"
    }
  }
}