# Cria Instancias
resource "aws_instance" "ec2-2" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.autoscaling_sg.id]
  subnet_id              = aws_subnet.subnet_pc["pvt_a"].id
  availability_zone      = "${var.aws_region}a"
  key_name               = var.key_pair_name
  user_data              = <<-EOF
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
  tags                   = merge(local.common_tags, { Name = "Desafio Hard 1A" })
}

# Cria Instancias
resource "aws_instance" "ec2-1" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.autoscaling_sg.id]
  subnet_id              = aws_subnet.subnet_pc["pvt_b"].id
  availability_zone      = "${var.aws_region}b"
  key_name               = var.key_pair_name
  user_data              = <<-EOF
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

  tags = merge(local.common_tags, { Name = "Desafio Hard 1B" })
}
