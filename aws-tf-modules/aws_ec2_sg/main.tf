resource "aws_security_group" "ec2_sg" {
  name        = var.security_group_name
  description = "Security group for EC2 instance with specific ports open"
  vpc_id      = var.vpc_id
  dynamic "ingress" {
    for_each = var.ingress_ports
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = "tcp"
      cidr_blocks = var.cidr_blocks
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Allow all outbound traffic
    cidr_blocks = var.cidr_blocks
  }

  tags = {
    Name = var.security_group_name
  }
}
