data "aws_ami" "get_ami"{
  most_recent = true
  owners = amazon

  filter {
    name = "name"
    values = ["myami-*"]
  }
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.get_ami.id
  instance_type = var.instance_type
  subnet        = var.subnet_id
  count         = var.instance_count

  tags = {
    Name = count.index == 0 ? "ansible_master" : "ansible_node"
  }
}