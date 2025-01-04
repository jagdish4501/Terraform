variable "vpc-cidr_block" {
  default = "14.0.0.0/16"
}
variable "public_subnet_cidr_block" {
  default = ["14.0.1.0/24"]
}
variable "public_subnet_azs" {
  default = ["ap-south-1a"]
}
variable "private_subnet_cidr_block" {
  default = ["14.0.2.0/24","14.0.3.0/24"]
}
variable "private_subnet_azs" {
  default = ["ap-south-1b","ap-south-1b"]
}
variable "instance_type" {
  default     = "t2.micro"
}
variable "ec2_ami" {
  default     = "ami-053b12d3152c0cc71"
}
variable "key_name" {
  default = "id_rsa_personal"
}
variable "public_key" {
  default = ""
}
variable "ingress_ports_master" {
  default = [{ from_port = 6443, to_port = 6443 },
    { from_port = 2379, to_port = 2380 },
    { from_port = 10250, to_port = 10250 },
    { from_port = 10259, to_port = 10259 },
    { from_port = 10257, to_port = 10257 }]
}