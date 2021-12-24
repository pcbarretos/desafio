# Route Table Publica
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc_pc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_pc.id
  }
  tags = merge(local.common_tags, { Name = "Route Public" })
}

# Route Table Privada
resource "aws_route_table" "private-1a" {
  vpc_id = aws_vpc.vpc_pc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_pub_a.id
  }
  tags = merge(local.common_tags, { Name = "Route Private 1A" })
}

# Route Table Privada
resource "aws_route_table" "private-1b" {
  vpc_id = aws_vpc.vpc_pc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_pub_b.id
  }
  tags = merge(local.common_tags, { Name = "Route Private 1B" })
}

# Atacha Route Table Publica no Internet Gateway Az 1A
resource "aws_route_table_association" "public_route_association" {
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.subnet_pc["pub_a"].id
}

# Atacha Route Table Privada 1A no NatGateway Az 1A
resource "aws_route_table_association" "private-1a_route_association" {
  subnet_id      = aws_subnet.subnet_pc["pvt_a"].id
  route_table_id = aws_route_table.private-1a.id
}

# Atacha Route Table Privada 1B no NatGateway Az 1B
resource "aws_route_table_association" "private-1b_route_association" {
  subnet_id      = aws_subnet.subnet_pc["pvt_b"].id
  route_table_id = aws_route_table.private-1b.id
}

