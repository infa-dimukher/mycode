terraform {
  backend "s3" {
    bucket = "terraform-backend"
    key    = "compute"
    region = "us-east-1"
  }
}