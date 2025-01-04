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

