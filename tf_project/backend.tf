/*
terraform {
  backend "s3" {
    bucket = "terraform-state-dib"
    key    = "tfstate-demo"
    region = "us-east-1"
  }
}
*/

terraform {
  backend "local" {
    path = "/Users/dimukher/Downloads/terraform.tfstate"
  }
}

