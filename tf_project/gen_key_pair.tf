resource "tls_private_key" "ec2_ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}


output "ec2_ssh_key" {
  value     = tls_private_key.ec2_ssh_key.public_key_openssh
  sensitive = true
}