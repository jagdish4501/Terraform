resource "aws_instance" "instance" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.security_group_ids
  associate_public_ip_address = var.associate_public_ip
  key_name                    = var.key_name
  user_data                   = var.user_data
  monitoring                  = var.monitoring
  disable_api_termination     = var.disable_api_termination
  tags                        = var.tags
  # EBS Block Device Configuration
  # dynamic "ebs_block_device" {
  #   for_each = var.ebs_volume_size > 0 ? [1] : []
  #   content {
  #     device_name = var.ebs_device_name
  #     volume_size = var.ebs_volume_size
  #     volume_type = var.ebs_volume_type
  #   }
  # }
  
}

# Optional Elastic IP attachment if enabled
resource "aws_eip" "elastic_ip" {
  instance = aws_instance.instance.id
  count    = var.assign_elastic_ip ? 1 : 0
}