output "security_group_id" {
  value       = aws_security_group.ec2_sg.id
}

output "security_group_name" {
  value       = aws_security_group.ec2_sg.name
}

output "security_group_description" {
  value       = aws_security_group.ec2_sg.description
}

output "security_group_vpc_id" {
  value       = aws_security_group.ec2_sg.vpc_id
}

output "security_group_ingress_ports" {
  value       = [
    "6443",
    "2379-2380",
    "10250",
    "10259",
    "10257"
  ]
}

output "security_group_cidr_blocks" {
  value       = var.cidr_blocks
}
