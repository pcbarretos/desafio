# Security Group Autoscaling
resource "aws_security_group" "autoscaling_sg" {
  name        = "SG Autoscaling "
  vpc_id      = aws_vpc.vpc_pc.id
  description = "Autoscaling SG"

  ingress {
    from_port       = 80
    protocol        = "tcp"
    to_port         = 80
    security_groups = [aws_security_group.loabalancer_sg.id]

  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(local.common_tags, { Name = "Autoscaling" })
}

# Security Group LB
resource "aws_security_group" "loabalancer_sg" {
  name        = "AppLoadBalancerSG"
  description = "Load Balancer SG"
  vpc_id      = aws_vpc.vpc_pc.id

  ingress {
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, { Name = "Load Balancer" })
}
