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
    Name = "public_subnet_${var.vpc_name}_${element(var.public_subnet_cidr_block, count.index)}"
  }
}
resource "aws_subnet" "private_subnets" {
  count = length(var.private_subnet_cidr_block)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = element(var.private_subnet_cidr_block, count.index)
  availability_zone       = element(var.private_subnet_azs,count.index)
  map_public_ip_on_launch = false
  tags = {
    Name = "private_subnet_${var.vpc_name}_${element(var.private_subnet_cidr_block, count.index)}"
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "internet_gateway_${var.vpc_name}"
  }
}

resource "aws_eip" "elastic_ip" {
  count = var.enable_nat_gateway ? 1 : 0
  tags = {
    Name = "elastic_ip_${var.vpc_name}"
  }
}
resource "aws_nat_gateway" "nat_gateway" {
  count = var.enable_nat_gateway ? 1 : 0
  subnet_id = aws_subnet.public_subnets[0].id
  allocation_id = aws_eip.elastic_ip[0].id
  tags = {
    Name = "nat_gateway_${var.vpc_name}"
  }
  depends_on = [aws_eip.elastic_ip]
}
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
  tags = {
    Name = "public_route_table_${var.vpc_name}"
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.main.id
  dynamic "route" {
    for_each = var.enable_nat_gateway?[1]:[]
    content {
      cidr_block = "0.0.0.0/0"
      nat_gateway_id = aws_nat_gateway.nat_gateway[0].id
    }
  }
  tags = {
    Name = "private_route_table_${var.vpc_name}"
  }
}
resource "aws_route_table_association" "public_route_table_association_with_subnet" {
  count          = length(var.public_subnet_cidr_block)
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_route_table.id
  depends_on = [ aws_subnet.public_subnets ,aws_route_table.public_route_table]
}
resource "aws_route_table_association" "private_route_table_association_with_subnet" {
  count = length(var.private_subnet_cidr_block)
  subnet_id = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private_route_table.id
  depends_on = [aws_subnet.private_subnets,aws_route_table.private_route_table ]
}

