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

variable "public_ami" {
  description = "The AMI ID for the public EC2 instance"
  type        = string
  default     = "ami-053b12d3152c0cc71"
}

variable "private_ami" {
  description = "The AMI ID for the private EC2 instances"
  type        = string
  default     = "ami-053b12d3152c0cc71"
}
