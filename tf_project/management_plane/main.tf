resource "tls_private_key" "ec2_ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "local_file" "ec2_private_key" {
  content         = tls_private_key.ec2_ssh_key.private_key_openssh
  filename        = "./ec2_private_key.pem"
  file_permission = "0400"
}

output "ec2_ssh_key" {
  value     = tls_private_key.ec2_ssh_key.public_key_openssh
  sensitive = true
}

resource "aws_vpc" "tf_project" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true

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

  tags = {
    Name = "tf-route-table"
  }
}

resource "aws_route" "tf_route_entry" {
  route_table_id         = aws_route_table.tf_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internetgw.id
  depends_on             = [aws_route_table.tf_route_table]
}

resource "aws_subnet" "tf_subnet" {
  vpc_id     = aws_vpc.tf_project.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "tf_subnet"
  }
}

resource "aws_route_table_association" "tf_route_attach" {
  subnet_id      = aws_subnet.tf_subnet.id
  route_table_id = aws_route_table.tf_route_table.id
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
  ami                         = data.aws_ami.get_ami.id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.tf_subnet.id
  count                       = var.instance_count
  key_name                    = aws_key_pair.demokeypair.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.tf_project_sg.id]


  tags = {
    Name = count.index == 0 ? "vault-admin" : "management_node"
  }
}

resource "null_resource" "demo" {

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = tls_private_key.ec2_ssh_key.private_key_openssh
    host        = aws_instance.demo[0].public_ip
  }

  provisioner "file" {
    source      = "scripts/vault_install.sh"
    destination = "/tmp/vault_install.sh"
  }

  provisioner "remote-exec" {

    inline = [
      "chmod +x /tmp/vault_install.sh",
      "/tmp/vault_install.sh",
    ]
  }
}

data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

resource "aws_security_group" "tf_project_sg" {
  name        = "tf_project_sg"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.tf_project.id

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.myip.response_body)}/32"]
  }

  ingress {
    description = "Opening port for vault service"
    from_port   = 8200
    to_port     = 8201
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.myip.response_body)}/32"]
  }

  ingress {
    description = "Opening port for HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.myip.response_body)}/32"]
  }

  ingress {
    description = "Opening port for HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.myip.response_body)}/32"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "tf_project_sg"
  }
}

resource "aws_key_pair" "demokeypair" {
  key_name   = var.key_pair_name
  public_key = tls_private_key.ec2_ssh_key.public_key_openssh
}

output "ec2_public_ip" {
  value = aws_instance.demo[*].public_ip
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

