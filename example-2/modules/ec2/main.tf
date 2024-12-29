variable "ami" {}
variable "instance_type" {}
variable "subnet_id" {}
variable "security_group_ids" {
  type = list(string)
}
variable "associate_public_ip" {
  default = false
}
variable "tags" {
  type = map(string)
}

resource "aws_instance" "instance" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.security_group_ids
  associate_public_ip_address = var.associate_public_ip
  tags                        = var.tags
}
