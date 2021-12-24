# retorna o ID da VPC
output "vpc_id" {
  value = aws_vpc.vpc_pc.id
}

# Retorna o Id do Internet Gateway
output "igw_id" {
  value = aws_internet_gateway.igw_pc.id
}

# Itera nas subnets e retorna a Tag Name e o ID das Subnets
output "subnet_ids" {
  value = local.subnet_ids
}

# retorna id route table
output "public_route_table_id" {
  value = aws_route_table.public.id
}
# retorna id route table
output "private_route_table_id_private-1a" {
  value = aws_route_table.private-1a.id
}
# retorna id route table
output "private_route_table_id_private-1b" {
  value = aws_route_table.private-1b.id
}

# retorna id sg lb
output "sg_loadbalancer_id" {
  value = aws_security_group.loabalancer_sg.id
}

# retorna id sg autoscaling
output "sg_autoscaling_id" {
  value = aws_security_group.autoscaling_sg.id
}

output "alb_id" {
  value = aws_lb.app_lb.id
}

output "aws_instance_id-1" {
  value = aws_instance.ec2-1.id
}

output "aws_instance_id-2" {
  value = aws_instance.ec2-2.id
}

output "aws_autoscaling_id" {
  value = aws_autoscaling_group.scaling.id
}
