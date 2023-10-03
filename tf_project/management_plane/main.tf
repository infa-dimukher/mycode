resource "tls_private_key" "ec2_ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "local_file" "ec2_private_key" {
  content  = tls_private_key.ec2_ssh_key.private_key_openssh
  filename = "./ec2_private_key.pem"
}

output "ec2_ssh_key" {
  value     = tls_private_key.ec2_ssh_key.public_key_openssh
  sensitive = true
}

resource "aws_vpc" "tf_project" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "tf_vpc"
  }
}

resource "aws_internet_gateway" "internetgw" {
  vpc_id = aws_vpc.tf_project.id

  tags = {
    Name = "tf_igw"
  }
}

resource "aws_route_table" "tf_route_table" {
  vpc_id = aws_vpc.tf_project.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internetgw.id
  }

  tags = {
    Name = "tf-route-table"
  }
}

resource "aws_subnet" "tf_subnet" {
  vpc_id     = aws_vpc.tf_project.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "tf_subnet"
  }
}

data "aws_ami" "get_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.1.20230912.0-kernel-6.1-x86_64*"]
  }
}

resource "aws_instance" "demo" {
  ami           = data.aws_ami.get_ami.id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.tf_subnet.id
  count         = var.instance_count
  key_name      = aws_key_pair.demokeypair.key_name

  tags = {
    Name = count.index == 0 ? "vault-admin" : "management_node"
  }
}


resource "aws_key_pair" "demokeypair" {
  key_name   = var.key_pair_name
  public_key = tls_private_key.ec2_ssh_key.public_key_openssh
}

# resource "vault_aws_secret_backend" "aws" {

#   path   = "${var.project_name}-path"
#   access_key = var.aws_access_key
#   secret_key = var.aws_secret_key
# }

# resource "vault_aws_secret_backend_role" "admin" {
#   backend         = vault_aws_secret_backend.aws.path
#   name            = "${var.project_name}-role"
#   credential_type = "iam_user"

#   policy_document = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Effect": "Allow",
#       "Action": [
#         "ec2:*",
#         "s3:*"
#       ],
#       "Resource": "*"
#     }
#   ]
# }
# EOF
# }

