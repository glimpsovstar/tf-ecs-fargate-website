resource "aws_ecs_task_definition" "website" {
  family                   = "${local.name_prefix}-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = local.execution_role_arn

  container_definitions = jsonencode([
    {
      name      = "website"
      image     = var.container_image
      essential = true
      
      portMappings = [
        {
          containerPort = 80
          protocol      = "tcp"
        }
      ]
      
      # Add logging configuration
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.website.name
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = "ecs"
        }
      }
      
      # Environment variables for demo
      environment = [
        {
          name  = "ENVIRONMENT"
          value = var.environment
        },
        {
          name  = "PROJECT_NAME"
          value = var.project_name
        },
        {
          name  = "REGION"
          value = var.aws_region
        }
      ]
    }
  ])

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-task-definition"
    Type = "ecs-task-definition"
  })
}