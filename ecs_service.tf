
resource "aws_ecs_service" "website" {
  name            = "website-service"
  cluster         = aws_ecs_cluster.website.id
  task_definition = aws_ecs_task_definition.website.arn
  launch_type     = "FARGATE"
  desired_count   = var.desired_count

  network_configuration {
    subnets          = var.subnet_ids
    security_groups  = [var.security_group_id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.website.arn
    container_name   = "website"
    container_port   = 80
  }

  depends_on = [aws_lb_listener.website]
}
