resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "main-vpc"
  }
}
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = var.public_subnet_az
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet"
  }
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = var.private_subnet_az
  tags = {
    Name = "private-subnet"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "main-gateway"
  }
}
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_security_group" "ec2_sg" {
  name        = "ec2-sg"
  description = "Security group for EC2 instances"
  vpc_id      = aws_vpc.main.id

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
  subnet_id           = aws_subnet.public.id
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
  subnet_id           = aws_subnet.private.id
  security_group_ids  = [aws_security_group.ec2_sg.id]
  associate_public_ip = false
  key_name            = aws_key_pair.jagdish.key_name
  tags = {
    Name = each.key
  }
}
