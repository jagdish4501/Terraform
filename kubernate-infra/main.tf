module "new_vpc" {
  source = "../aws-tf-modules/aws_vpc"
  vpc_cidr = var.vpc-cidr_block
  vpc_name = "kubernate-vpc"
  public_subnet_cidr_block=var.public_subnet_cidr_block
  public_subnet_azs=var.public_subnet_azs
  private_subnet_cidr_block = var.private_subnet_cidr_block
  private_subnet_azs = var.private_subnet_azs
  enable_nat_gateway = false
}
module "ec2_master_node_sg" {
  source = "../aws-tf-modules/aws_ec2_sg"
  vpc_id = module.new_vpc.vpc_id
  ingress_ports = var.ingress_ports_master
  security_group_name = "master_node_sg"
}
module "ec2_worker_node_sg" {
  source = "../aws-tf-modules/aws_ec2_sg"
  vpc_id = module.new_vpc.vpc_id
  ingress_ports = var.ingress_ports_worker
  security_group_name = "worker_node_sg"
}

resource "aws_key_pair" "jagdish" {
  key_name   = var.key_name
  public_key = var.public_key
}

module "public_instance" {
  source              = "../aws-tf-modules/aws_ec2"
  ami                 = var.ec2_ami
  instance_type       = var.instance_type
  subnet_id           = module.new_vpc.public_subnet_ids[0]
  security_group_ids  = [module.ec2_master_node_sg.sg_id]
  associate_public_ip = true
  key_name            = aws_key_pair.jagdish.key_name
  tags = {
    Name = "public-ec2-instance"
  }
  depends_on = [ module.ec2_master_node_sg ,module.new_vpc]
}


module "private_instances" {
  source              = "../aws-tf-modules/aws_ec2"
  for_each            = toset(["private-ec2-instance-1", "private-ec2-instance-2"])
  ami                 = var.ec2_ami
  instance_type       = var.instance_type
  subnet_id           = module.new_vpc.private_subnet_ids[0]
  security_group_ids  = [module.ec2_worker_node_sg.sg_id]
  associate_public_ip = false
  key_name            = aws_key_pair.jagdish.key_name
  tags = {
    Name = each.key
  }
  depends_on = [ module.ec2_worker_node_sg ,module.new_vpc]
}
