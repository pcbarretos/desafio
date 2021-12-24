# Usa o For-Each para Iterar Sobre os Itens [0,1,2]
resource "aws_subnet" "subnet_pc" {
  for_each = {
    "pub_a" : ["10.0.1.0/24", "${var.aws_region}a", "Publica-1A"]
    "pub_b" : ["10.0.2.0/24", "${var.aws_region}b", "Publica-1B"]
    "pvt_a" : ["10.0.3.0/24", "${var.aws_region}a", "Private-1A"]
    "pvt_b" : ["10.0.4.0/24", "${var.aws_region}b", "Private-1B"]
  }
  vpc_id            = aws_vpc.vpc_pc.id
  cidr_block        = each.value[0]
  availability_zone = each.value[1]
  tags              = merge(local.common_tags, { Name = each.value[2] })
}
