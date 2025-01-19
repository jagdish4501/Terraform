output "vpc_id" {
  value = aws_vpc.main.id
}
output "public_subnet_ids" {
  value = aws_subnet.public_subnets[*].id
}
output "private_subnet_ids" {
  value = aws_subnet.private_subnets[*].id
}
output "internet_gateway_id" {
  value = aws_internet_gateway.internet_gateway.id
}
output "public_route_table_id" {
  value = aws_route_table.public_route_table.id
}
output "private_route_table_id" {
  value = aws_route_table.private_route_table.id
}
output "elastic_ip" {
  value = var.enable_nat_gateway ? aws_eip.elastic_ip[0].public_ip : null
}
output "nat_gateway_public_ip" {
  value = var.enable_nat_gateway ? aws_nat_gateway.nat_gateway[0].public_ip : null
}
output "nat_gateway_id" {
  value = var.enable_nat_gateway ? aws_nat_gateway.nat_gateway[0].id : null
}
