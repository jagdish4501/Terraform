#output section for ec2 instances 
output "public_instances_ids" {
  description = "List of IDs for public EC2 instances"
  value       = [for i in aws_instance.public_instances : i.id]
}

output "public_instances_private_ips" {
  description = "List of private IPs for public EC2 instances"
  value       = [for i in aws_instance.public_instances : i.private_ip]
}

output "public_instances_public_ips" {
  description = "List of public IPs for public EC2 instances"
  value       = [for i in aws_instance.public_instances : i.public_ip]
}

output "public_instances_private_dns" {
  description = "List of private DNS names for public EC2 instances"
  value       = [for i in aws_instance.public_instances : i.private_dns]
}

output "public_instances_public_dns" {
  description = "List of public DNS names for public EC2 instances"
  value       = [for i in aws_instance.public_instances : i.public_dns]
}

output "private_instances_ids" {
  description = "List of IDs for private EC2 instances"
  value       = [for i in aws_instance.private_instances : i.id]
}

output "private_instances_private_ips" {
  description = "List of private IPs for private EC2 instances"
  value       = [for i in aws_instance.private_instances : i.private_ip]
}

output "private_instances_private_dns" {
  description = "List of private DNS names for private EC2 instances"
  value       = [for i in aws_instance.private_instances : i.private_dns]
}

output "instance_type" {
  value = var.instance_type
}
output "ami" {
  value = var.ami
}
output "key_name" {
  value = var.key_name
}

output "key_pair_name" {
  value = aws_key_pair.id_rsa.key_name
}

output "key_pair_tags" {
  value = aws_key_pair.id_rsa.tags
}

#output section for VPC and related resources 
output "elastic_ip" {
  value = module.kubernate_vpc.elastic_ip
}
output "nat_gateway_public_ip" {
  value = module.kubernate_vpc.nat_gateway_public_ip
}
output "vpc_id" {
  value = module.kubernate_vpc.vpc_id
}
output "public_subnet_ids" {
  value = module.kubernate_vpc.public_subnet_ids
}
output "private_subnet_ids" {
  value = module.kubernate_vpc.private_subnet_ids
}
output "master_node_sg_id" {
  value = module.ec2_master_node_sg.sg_id
}
output "worker_node_sg_id" {
  value = module.ec2_worker_node_sg.sg_id
}
output "vpc_name" {
  value = module.kubernate_vpc.vpc_name
}
output "public_subnet_cidr_block" {
  value = module.kubernate_vpc.public_subnet_cidr_block
}
output "private_subnet_cidr_block" {
  value = module.kubernate_vpc.private_subnet_cidr_block
}
output "public_subnet_azs" {
  value = module.kubernate_vpc.public_subnet_azs
}
output "private_subnet_azs" {
  value = module.kubernate_vpc.private_subnet_azs
}
output "enable_nat_gateway" {
  value = module.kubernate_vpc.enable_nat_gateway
}


output "ingress_ports_master" {
  value = var.ingress_ports_master
}
output "ingress_ports_worker" {
  value = var.ingress_ports_worker
}
