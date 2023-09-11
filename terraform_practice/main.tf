resource "aws_instance" "web" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet        = var.subnet_id
  count         = var.instance_count

  tags = {
    Name = count.index == 0 ? "ansible_master" : "ansible_node"
  }
}