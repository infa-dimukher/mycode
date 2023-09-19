resource "vault_aws_secret_backend" "aws" {
  path        = "aws"
  access_key  = "AKIAYYHZB24PSGUPS2Y3"
  secret_key  = "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"
}


resource "vault_auth_backend" "aws" {
  path = "auth/aws"
}


resource "vault_auth_backend_role" "my_role" {
  backend            = vault_auth_backend.aws.path
  name               = "tfdemo-role"
}
