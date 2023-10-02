resource "tls_private_key" "ec2_ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "local_file" "ec2_private_key {
  content = tls_private_key.ec2_ssh_key.private_key_openssh
  filename             = "./ec2_private_key.pem"
}
"

output "ec2_ssh_key" {
  value     = tls_private_key.ec2_ssh_key.public_key_openssh
  sensitive = true
}