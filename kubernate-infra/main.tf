module "new_vpc" {
  source = "../aws-tf-modules/vpc"
  vpc_cidr = var.vpc-cidr_block
  vpc_name = "kubernate-vpc"
  public_subnet_cidr_block=var.public_subnet_cidr_block
  public_subnet_azs=var.public_subnet_azs
  private_subnet_cidr_block = var.private_subnet_cidr_block
  private_subnet_azs = var.private_subnet_azs
}


resource "aws_security_group" "ec2_sg" {
  name        = "ec2-sg"
  description = "Security group for EC2 instances"
  vpc_id      = module.new_vpc.vpc_id
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }
}


resource "aws_key_pair" "jagdish" {
  key_name   = var.key_name
  public_key = var.public_key
}

module "public_instance" {
  source              = "./modules/ec2"
  ami                 = var.ec2_ami
  instance_type       = var.instance_type
  subnet_id           = module.new_vpc.public_subnet_ids[0]
  security_group_ids  = [aws_security_group.ec2_sg.id]
  associate_public_ip = true
  key_name            = aws_key_pair.jagdish.key_name
  tags = {
    Name = "public-ec2-instance"
  }
}


module "private_instances" {
  source              = "./modules/ec2"
  for_each            = toset(["private-ec2-instance-1", "private-ec2-instance-2"])
  ami                 = var.ec2_ami
  instance_type       = var.instance_type
  subnet_id           = module.new_vpc.private_subnet_ids[0]
  security_group_ids  = [aws_security_group.ec2_sg.id]
  associate_public_ip = false
  key_name            = aws_key_pair.jagdish.key_name
  tags = {
    Name = each.key
  }
}
