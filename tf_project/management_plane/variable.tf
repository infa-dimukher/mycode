variable "project_name" {
  type    = string
  default = "dynamic_aws_creds_demo"
}

variable "aws_access_key" {}

variable "aws_secret_key" {}

variable "ami_id" {
  type    = string
  default = ""
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

# variable "subnet_id" {
#   type = string
# }

variable "instance_count" {
  type    = number
  default = 2
}

variable "key_pair_name" {}