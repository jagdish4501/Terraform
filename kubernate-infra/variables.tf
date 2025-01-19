variable "vpc_name" {
  type = string
}
variable "vpc_cidr_block" {
  type    = string
}
variable "public_subnet_cidr_block" {
  type    = list(string)
}
variable "public_subnet_azs" {
  type    = list(string)
}
variable "private_subnet_cidr_block" {
  type    = list(string)
}
variable "private_subnet_azs" {
  type    = list(string)
}
variable "enable_nat_gateway" {
  type = bool
}
variable "instance_type" {
  type    = string
}
variable "ec2_ami" {
  type    = string
}
variable "key_name" {
  type = string
}
variable "public_key" {
  type = string
}
variable "ingress_ports_master" {
  type = list(object({
    from_port = string,
    to_port=string
    protocol=string
  }))
}

variable "ingress_ports_worker" {
  type = list(object({
    from_port = string,
    to_port=string
    protocol=string
  }))
}