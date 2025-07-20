output "sg_id" {
  value       = aws_security_group.ec2_sg.id
}

output "sg_name" {
  value       = aws_security_group.ec2_sg.name
}

output "vpc_id" {
  value       = var.vpc_id
}
output "ingress_ports" {
  value       = var.ingress_ports
}

