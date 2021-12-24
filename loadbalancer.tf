# Cria loadblancer
resource "aws_lb" "app_lb" {
  name            = "LoadBalancer"
  security_groups = [aws_security_group.loabalancer_sg.id]
  subnets         = [aws_subnet.subnet_pc["pub_a"].id, aws_subnet.subnet_pc["pub_b"].id]

  tags = merge(local.common_tags, { Name = "Load Balancer" })
}

# cria target para acessar instancia
resource "aws_lb_target_group" "target_alb" {
  name     = "ALBTarget"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc_pc.id

  health_check {
    path              = "/"
    healthy_threshold = 2
  }
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_alb.arn
  }
}
