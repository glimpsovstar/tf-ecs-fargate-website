resource "aws_lb" "website" {
  name               = "${local.name_prefix}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [local.security_group_id]
  subnets            = local.subnet_ids

  enable_deletion_protection = false

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-alb"
    Type = "application-load-balancer"
  })
}

resource "aws_lb_target_group" "website" {
  name        = "${local.name_prefix}-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = local.vpc_id
  target_type = "ip"  # Required for Fargate

  health_check {
    enabled             = true
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    path                = "/"
    matcher             = "200-399"
    port                = "traffic-port"
    protocol            = "HTTP"
  }

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-target-group"
    Type = "alb-target-group"
  })
}

resource "aws_lb_listener" "website" {
  load_balancer_arn = aws_lb.website.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.website.arn
  }

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-listener"
    Type = "alb-listener"
  })
}