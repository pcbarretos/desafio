# Cria NatGateway
resource "aws_nat_gateway" "nat_pub_a" {
  subnet_id     = aws_subnet.subnet_pc["pub_a"].id
  allocation_id = aws_eip.eip_nat_pub_a.id

  tags = merge(local.common_tags, { Name = "NatGateway 1A" })
}

# Cria NatGateway
resource "aws_nat_gateway" "nat_pub_b" {
  subnet_id     = aws_subnet.subnet_pc["pub_b"].id
  allocation_id = aws_eip.eip_nat_pub_b.id

  tags = merge(local.common_tags, { Name = "NatGateway 1B" })
}

# Cria Eip para o Nat
resource "aws_eip" "eip_nat_pub_a" {
  vpc  = true
  tags = merge(local.common_tags, { Name = "NatGateway EIP 1A" })
}

# Cria Eip para o Nat
resource "aws_eip" "eip_nat_pub_b" {
  vpc  = true
  tags = merge(local.common_tags, { Name = "NatGateway EIP 1B" })
}
