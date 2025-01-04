resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  enable_dns_support = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "public_subnets" {
  count = length(var.public_subnet_cidr_block)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = element(var.public_subnet_cidr_block, count.index)
  availability_zone       = element(var.public_subnet_azs,count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "public_subnet-${element(var.public_subnet_cidr_block, count.index)}"
  }
}

resource "aws_subnet" "private_subnets" {
  count = length(var.private_subnet_cidr_block)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = element(var.private_subnet_cidr_block, count.index)
  availability_zone       = element(var.private_subnet_azs,count.index)
  map_public_ip_on_launch = false
  tags = {
    Name = "private_subnet-${element(var.private_subnet_cidr_block, count.index)}"
  }
}

resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.vpc_name}-internet-gateway"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gateway.id
  }
  tags = {
    Name = "${var.vpc_name}-route-table"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.vpc_name}-private-route-table"
  }
}


resource "aws_route_table_association" "public_association" {
  count          = length(var.public_subnet_cidr_block)
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public.id
}


resource "aws_route_table_association" "private_association" {
  count = length(var.private_subnet_cidr_block)
  subnet_id = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private.id
}

# aws_route_table association is option if we dont associate any route table it will we associate with default route table created by vpc
