resource "aws_security_group" "ec2_sg" {
  description = "Security group for EC2 instance"
  name        = var.security_group_name
  vpc_id      = var.vpc_id
  dynamic "ingress" {
    for_each = var.ingress_ports
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = var.allowed_ingress_cidr_blocks
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Allow all outbound traffic
    cidr_blocks = var.allowed_egress_cidr_blocks
  }
  tags = {
    Name = var.security_group_name
  }
}
