output "instance_id" {
  value = aws_instance.instance.id
}
output "public_ip" {
  value = aws_instance.instance.public_ip
}
output "private_ip" {
  value = aws_instance.instance.private_ip
}
output "public_dns" {
  value = aws_instance.instance.public_dns
}
output "private_dns" {
  value = aws_instance.instance.private_dns
}
output "subnet_id" {
  value = aws_instance.instance.subnet_id
}
output "elastic_ip" {
  value = aws_eip.elastic_ip[*].public_ip
}
output "instance_type" {
  value = aws_instance.instance.instance_type
}
output "security_group_ids" {
  value = aws_instance.instance.vpc_security_group_ids
}
output "key_name" {
  value = aws_instance.instance.key_name        
}
output "tags" {
  value = aws_instance.instance.tags
}
output "ami" {
  value = aws_instance.instance.ami
}
output "user_data" {
  value = aws_instance.instance.user_data
}
output "monitoring" {
  value = aws_instance.instance.monitoring
}
output "disable_api_termination" {
  value = aws_instance.instance.disable_api_termination
} 
output "assign_elastic_ip" {
  value = var.assign_elastic_ip
}
output "elastic_ip_assigned" {
  value = length(aws_eip.elastic_ip) > 0 ? aws_eip.elastic_ip[0].public_ip : null
}
output "elastic_ip_id" {
  value = length(aws_eip.elastic_ip) > 0 ? aws_eip.elastic_ip[0].id : null
}
output "elastic_ip_allocation_id" {
  value = length(aws_eip.elastic_ip) > 0 ? aws_eip.elastic_ip[0].allocation_id : null
}
output "elastic_ip_association_id" {
  value = length(aws_eip.elastic_ip) > 0 ? aws_eip.elastic_ip[0].association_id : null
}

output "instance_state" {
  value = aws_instance.instance.state
}
output "instance_tags" {
  value = aws_instance.instance.tags
}
output "instance_availability_zone" {
  value = aws_instance.instance.availability_zone   
}
output "instance_root_block_device" {
  value = aws_instance.instance.root_block_device
}
output "instance_volume_tags" {
  value = aws_instance.instance.ebs_block_device[*].tags
}
output "instance_volume_ids" {
  value = aws_instance.instance.ebs_block_device[*].volume_id
}   
output "instance_volume_size" {
  value = aws_instance.instance.ebs_block_device[*].volume_size
}
output "instance_volume_type" {
  value = aws_instance.instance.ebs_block_device[*].volume_type   
}
output "instance_volume_iops" {
  value = aws_instance.instance.ebs_block_device[*].iops      
} 
output "instance_volume_throughput" {
  value = aws_instance.instance.ebs_block_device[*].throughput
}
output "instance_volume_encrypted" {
  value = aws_instance.instance.ebs_block_device[*].encrypted 
}
output "instance_volume_kms_key_id" {   
  value = aws_instance.instance.ebs_block_device[*].kms_key_id
}
output "instance_volume_delete_on_termination" {
  value = aws_instance.instance.ebs_block_device[*].delete_on_termination
}
output "instance_volume_snapshot_id" {
  value = aws_instance.instance.ebs_block_device[*].snapshot_id
}
output "instance_volume_device_name" {
  value = aws_instance.instance.ebs_block_device[*].device_name 
}
output "instance_volume_no_device" {
  value = aws_instance.instance.ebs_block_device[*].no_device
}
output "instance_volume_iops" {   
  value = aws_instance.instance.ebs_block_device[*].iops
}
output "instance_volume_throughput" {
  value = aws_instance.instance.ebs_block_device[*].throughput
}
output "instance_volume_encrypted" {    
  value = aws_instance.instance.ebs_block_device[*].encrypted
}
output "instance_volume_kms_key_id" { 
  value = aws_instance.instance.ebs_block_device[*].kms_key_id
}
output "instance_volume_delete_on_termination" {  
  value = aws_instance.instance.ebs_block_device[*].delete_on_termination
}