variable "ingress_ports" {
  description = "List of ingress ports or port ranges to allow"
  type = list(object({
    from_port = number
    to_port   = number
  }))
  default = [
    { from_port = 6443, to_port = 6443 },
  ]
}
variable "cidr_blocks" {
  description = "CIDR blocks allowed to access the EC2 instance on the specified ports"
  type        = list(string)
  default     = ["0.0.0.0/0"] 
}

variable "security_group_name" {
  description = "The name of the security group"
  type        = string
  default     = "ec2_sg"
}

variable "vpc_id" {
  description = "The ID of the VPC where the security group will be created"
  type        = string
}
