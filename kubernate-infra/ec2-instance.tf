resource "aws_key_pair" "id_rsa" {
  key_name   = var.key_name
  public_key = var.public_key
  tags = {
    Name = "kubernate_key_pair"
  }
  lifecycle {
    prevent_destroy = false  # Prevent accidental deletion
  }
}

resource "aws_instance" "public_instances" {
  for_each                    = toset(["public-ec2-instance"])
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = module.kubernate_vpc.public_subnet_ids[0]
  vpc_security_group_ids      = [module.ec2_master_node_sg.sg_id]
  associate_public_ip_address = false
  key_name                    = aws_key_pair.id_rsa.key_name
  monitoring                  = true
  disable_api_termination     = false
  ebs_optimized               = true
  #ebs block for root volume
  root_block_device {
    volume_size = 30
    volume_type = "gp2"
    delete_on_termination = true
  }
  #ebs block for additional volume
  ebs_block_device {
    device_name = "/dev/sdh"
    volume_size = 100
    volume_type = "gp2"
    delete_on_termination = true
  }

  tags = {
    Name = "ec2-${each.key}"
  }
  lifecycle {
    prevent_destroy = false
  }
  depends_on = [module.ec2_master_node_sg, module.kubernate_vpc]
}

# Optional Elastic IP attachment if enabled
resource "aws_eip" "elastic_ip" {
  count    = var.assign_elastic_ip ? 1 : 0
  instance = aws_instance.public_instances["public-ec2-instance"].id
  lifecycle {
    prevent_destroy = false
  }
  tags = {
    Name = "Elastic IP public for EC2 Instance"
  }
}

resource "aws_instance" "private_instances" {
  for_each                    = toset(["private-ec2-instance-1", "private-ec2-instance-2"])
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = module.kubernate_vpc.public_subnet_ids[0]
  vpc_security_group_ids      = [module.ec2_worker_node_sg.sg_id]
  associate_public_ip_address = false
  key_name                    = aws_key_pair.id_rsa.key_name
  monitoring                  = true
  disable_api_termination     = false
  ebs_optimized               = true
  #ebs block for root volume
  ebs_block_device {
    device_name = "/dev/sdh"
    volume_size = 10
    volume_type = "gp2"
    delete_on_termination = true

  }
   tags = {
    Name = "ec2-${each.key}"
  }
  lifecycle {
    prevent_destroy = false
  }
  depends_on = [module.ec2_master_node_sg, module.kubernate_vpc]
}
