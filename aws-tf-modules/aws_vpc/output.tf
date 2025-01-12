output "vpc_id" {
  value       = aws_vpc.main.id
}
output "public_subnet_ids" {
  value       = aws_subnet.public_subnets[*].id
}
output "private_subnet_ids" {
  value = aws_subnet.private_subnets[*].id
}
output "public_subnet_azs" {
  value = aws_subnet.public_subnets[*].availability_zone 
}
output "private_subnet_azs" {
  value = aws_subnet.private_subnets[*].availability_zone
}
output "internet_gateway_id" {
  value       = aws_internet_gateway.gateway.id
}
output "public_route_table_id" {
  value       = aws_route_table.public.id
}

output "private_route_table_id" {
  value = aws_route_table.private.id
}
output "elastic_ip" {
  value = var.enable_nat_gateway?aws_eip.elastic_ip[0].public_ip:""
}

output "nat_elastic_ip" {
  value = var.enable_nat_gateway?aws_nat_gateway.gateway[0].public_ip:""
}
output "nat_gateway_id" {
  value = var.enable_nat_gateway?aws_nat_gateway.gateway[0].id:""
}