# Busca instancia AMI
data "aws_ami" "ubuntu" {
  owners      = ["amazon"]
  most_recent = true
  name_regex  = "ubuntu"

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}


## Cria par de Chaves
#resource "tls_private_key" "key_pc" {
#  algorithm = "RSA"
#  rsa_bits  = 4096
#}
#
## Cria par de Chaves
#resource "aws_key_pair" "generated_key" {
#  key_name   = var.key_pair_name
#  public_key = tls_private_key.key_pc.public_key_openssh
#}

# Cria template Autoscaling
resource "aws_launch_template" "tpl" {
  name_prefix   = "terraform-"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name      = var.key_pair_name
  user_data     = <<-EOF
              #!/bin/bash
              mkdir -p home/project
              sudo apt update -y
              sudo apt install -y docker docker-compose git
              git config --global user.name "Pcbarreto"
              git config --global user.email "paullo.barreto@gmail.com"
              git clone https://github.com/thejungwon/docker-webapp-django.git
              cd docker-webapp-django/
              sudo docker-compose -d up
              EOF
  monitoring {
    enabled = true
  }

  network_interfaces {
    associate_public_ip_address = true
    delete_on_termination       = true
    security_groups             = [aws_security_group.autoscaling_sg.id]
  }
}

# Cria Grupo Autoscaling
resource "aws_autoscaling_group" "scaling" {
  name                = "Terraform-Autoscaling"
  vpc_zone_identifier = [aws_subnet.subnet_pc["pvt_a"].id, aws_subnet.subnet_pc["pvt_b"].id]
  max_size            = 3
  min_size            = 1

  health_check_grace_period = 280
  health_check_type         = "ELB"
  force_delete              = true
  target_group_arns         = [aws_lb_target_group.target_alb.id]

  launch_template {
    id      = aws_launch_template.tpl.id
    version = aws_launch_template.tpl.latest_version
  }

}

# Cria Police do Autoscaling
resource "aws_autoscaling_policy" "scalingup" {
  name                   = "ScaleUp"
  autoscaling_group_name = aws_autoscaling_group.scaling.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "1"
  cooldown               = "180"
  policy_type            = "SimpleScaling"
}

# Cria Police do Autoscaling
resource "aws_autoscaling_policy" "scalingdown" {
  name                   = "ScaleDown"
  autoscaling_group_name = aws_autoscaling_group.scaling.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "-1"
  cooldown               = "180"
  policy_type            = "SimpleScaling"
}

