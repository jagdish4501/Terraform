output "public_instance_id" {
  value = module.public_instance.instance_id
}

output "private_instance_1_id" {
  value = module.private_instances["private-ec2-instance-1"].instance_id
}
output "private_instance_2_id" {
  value = module.private_instances["private-ec2-instance-2"].instance_id
}

output "public_instance_public_ip" {
  value = module.public_instance.public_ip
}

output "public_instance_private_ip" {
  value = module.public_instance.private_ip
}
output "private_instance_1_private_ip" {
  value = module.private_instances["private-ec2-instance-1"].private_ip
}
output "private_instance_2_private_ip" {
  value = module.private_instances["private-ec2-instance-2"].private_ip
}

output "elastic_ip" {
  value = module.new_vpc.elastic_ip
}

output "elastic_ip_nat" {
  value = module.new_vpc.nat_elastic_ip
}