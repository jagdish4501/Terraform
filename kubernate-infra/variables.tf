variable "public_subnet_az" {
  description = "The availability zone for the public subnet"
  type        = string
  default     = "ap-south-1a"
}

variable "private_subnet_az" {
  description = "The availability zone for the private subnet"
  type        = string
  default     = "ap-south-1b"
}

variable "instance_type" {
  description = "The EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "ec2_ami" {
  description = "The AMI ID for the EC2 instance"
  type        = string
  default     = "ami-053b12d3152c0cc71"
}

variable "key_name" {
  type    = string
  default = "id_rsa_personal"
}

variable "public_key" {
  type    = string
  default = ""
}
