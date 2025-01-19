output "public_instance_ids" {
  value = { for key, instance in module.public_instance : key => instance.instance_id }
}

output "public_instance_public_ips" {
  value = { for key, instance in module.public_instance : key => instance.public_ip }
}

output "public_instance_private_ips" {
  value = { for key, instance in module.public_instance : key => instance.private_ip }
}

output "private_instance_ids" {
  value = { for key, instance in module.private_instances : key => instance.instance_id }
}

output "private_instance_private_ips" {
  value = { for key, instance in module.private_instances : key => instance.private_ip }
}

output "elastic_ip" {
  value = module.kubernate_vpc.elastic_ip
}

output "nat_gateway_public_ip" {
  value = module.kubernate_vpc.nat_gateway_public_ip
}
