data "aws_ami" "get_ami"{
  most_recent = true
  owners = ["amazon"]

  filter {
    name = "name"
    values = ["al2023-ami-2023.1.20230912.0-kernel-6.1-x86_64*"]
  }
}

resource "aws_instance" "demo" {
  ami           = data.aws_ami.get_ami.id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  count         = var.instance_count
  key_name		= aws_key_pair.demokeypair.key_name

  tags = {
    Name = count.index == 0 ? "ansible_master" : "ansible_node"
  }
}


resource "aws_key_pair" "demokeypair" {
  key_name   = var.key_pair_name
  public_key = tls_private_key.ec2_ssh_key.public_key_openssh
}