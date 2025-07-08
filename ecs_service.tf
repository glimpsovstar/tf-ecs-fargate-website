resource "aws_ecs_service" "website" {
  name            = "${local.name_prefix}-service"
  cluster         = aws_ecs_cluster.website.id
  task_definition = aws_ecs_task_definition.website.arn
  launch_type     = "FARGATE"
  desired_count   = var.desired_count


  network_configuration {
    subnets          = local.subnet_ids
    security_groups  = [local.security_group_id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.website.arn
    container_name   = "website"
    container_port   = 80
  }

  depends_on = [aws_lb_listener.website]

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-ecs-service"
    Type = "ecs-service"
  })

  lifecycle {
    ignore_changes = [task_definition]
  }
}