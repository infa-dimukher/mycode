variable "ami_id" {
  type    = string
  default = ""
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "subnet_id" {
  type = string
}

variable "instance_count" {
  type    = number
  default = 1
}

variable "key_pair_name" {}


