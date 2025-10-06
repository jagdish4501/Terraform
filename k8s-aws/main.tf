module "kubernate_vpc" {
  source                    = "../aws-tf-modules/aws_vpc"
  vpc_cidr                  = var.vpc_cidr_block # Corrected variable name
  vpc_name                  = var.vpc_name
  public_subnet_cidr_block  = var.public_subnet_cidr_block
  public_subnet_azs         = var.public_subnet_azs
  private_subnet_cidr_block = var.private_subnet_cidr_block
  private_subnet_azs        = var.private_subnet_azs
  enable_nat_gateway        = var.enable_nat_gateway
}

module "ec2_master_node_sg" {
  source              = "../aws-tf-modules/aws_ec2_sg"
  vpc_id              = module.kubernate_vpc.vpc_id
  ingress_ports       = var.ingress_ports_master
  security_group_name = "master_node_sg"
}

module "ec2_worker_node_sg" {
  source              = "../aws-tf-modules/aws_ec2_sg"
  vpc_id              = module.kubernate_vpc.vpc_id
  ingress_ports       = var.ingress_ports_worker
  security_group_name = "worker_node_sg"
}