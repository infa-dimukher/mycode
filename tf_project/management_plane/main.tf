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

terraform {
  backend "local" {
    path = "/Users/dimukher/Downloads/terraform.tfstate"
  }
}

provider "tls" {}

provider "vault" {}

variable "project_name" {
  type        = string
  default     = "dynamic_aws_creds_demo"
}

variable "aws_access_key" {}

variable "aws_secret_key" {}

resource "vault_aws_secret_backend" "aws" {

  path   = "${var.project_name}-path"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

resource "vault_aws_secret_backend_role" "admin" {
  backend         = vault_aws_secret_backend.aws.path
  name            = "${var.project_name}-role"
  credential_type = "iam_user"

  policy_document = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:*",
        "s3:*"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

