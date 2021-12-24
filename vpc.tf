# Cria VPC e Habilita dns hostname
resource "aws_vpc" "vpc_pc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags                 = merge(local.common_tags, { Name = "VPC Do PC" })
}

# Cria Internet Gateway
resource "aws_internet_gateway" "igw_pc" {
  vpc_id = aws_vpc.vpc_pc.id
  tags   = merge(local.common_tags, { Name = "IGW do PC" })
}

