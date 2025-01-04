variable "vpc_id" {
  type        = string
}
variable "ingress_ports" {
  type = list(object({
    from_port = number
    to_port   = number
  }))
  default = [{ from_port = 22, to_port = 22 }]
}
variable "allowed_ingress_cidr_blocks" {
  type        = list(string)
  default     = ["0.0.0.0/0"] 
}

variable "allowed_egress_cidr_blocks" {
  type = list(string)
  default = ["0.0.0.0/0"]
}
variable "security_group_name" {
  type        = string
  default     = "ec2_sg"
}

