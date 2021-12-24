locals {
  subnet_ids = { for k, v in aws_subnet.subnet_pc : v.tags.Name => v.id }

  common_tags = {
    Project   = "Desafio Terraform Hard"
    CreatedAt = "21-12-2021"
    ManagedBy = "Terraform"
    Owner     = "Paulo Barreto"
  }
}
