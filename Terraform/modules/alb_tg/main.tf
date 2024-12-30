
# Create Application Load Balancer
resource "aws_lb" "alb" {
  name               = join("-", [var.system_code, "-alb"])
  internal           = false
  vpc_id             = var.vpc_id
  load_balancer_type = "application"
  security_groups    = [var.security_groups]
  subnets            = var.public_subnets
  enable_deletion_protection = false
  tags = {
    Name = join("-", [var.system_code, "-alb"])
  }
}

resource "aws_lb_target_group" "alb_tg" {
  name        = join("-", [var.system_code, "-tg"])
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"
  health_check {
    interval = 5
    path = "/"
  }
  tags = {
    Name = join("-", [var.system_code, "-tg"])
  }
}