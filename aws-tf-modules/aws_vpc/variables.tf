variable "vpc_name" {
  type        = string
  default     = "my-vpc"
}
variable "vpc_cidr" {
  type        = string
  default     = "10.0.0.0/16"
}
variable "public_subnet_cidr_block" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
}
variable "private_subnet_cidr_block" {
  type        = list(string)
  default     = ["10.0.2.0/24","10.0.3.0/24"]
}
variable "public_subnet_azs" {
  type = list(string)
  default = ["ap-south-1a"]
}
variable "private_subnet_azs" {
  type = list(string)
  default = ["ap-south-1b","ap-south-1c"]
}
variable "enable_nat_gateway" {
  type = bool
  default = false
}
variable "enable_dns_support" {
  type = bool
  default = true
}
variable "enable_dns_hostnames" {
  type = bool
  default = true
}