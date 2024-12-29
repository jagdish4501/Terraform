output "public_instance_id" {
  description = "ID of the EC2 instance in the public subnet"
  value       = aws_instance.public_instance.id
}

output "private_instance_1_id" {
  description = "ID of the first EC2 instance in the private subnet"
  value       = aws_instance.private_instance_1.id
}

output "private_instance_2_id" {
  description = "ID of the second EC2 instance in the private subnet"
  value       = aws_instance.private_instance_2.id
}

output "public_instance_public_ip" {
  description = "Public IP of the EC2 instance in the public subnet"
  value       = aws_instance.public_instance.public_ip
}
