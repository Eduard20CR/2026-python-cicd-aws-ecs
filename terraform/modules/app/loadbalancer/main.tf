resource "aws_lb" "this" {
  name               = "${var.project_identifier}-lb-app"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group_id]
  subnets            = var.subnet_ids


  enable_deletion_protection = false
}

resource "aws_lb_target_group" "this" {
  name        = "${var.project_identifier}-tg"
  vpc_id      = var.vpc_id
  protocol    = "HTTP"
  port        = var.container_port
  target_type = "ip"

  health_check {
    path                = "/health"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    matcher             = "200-399"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}
