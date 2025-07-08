resource "aws_ecs_cluster" "website" {
  name = "${local.name_prefix}-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-ecs-cluster"
    Type = "ecs-cluster"
  })
}

# CloudWatch Log Group for ECS tasks
resource "aws_cloudwatch_log_group" "website" {
  name              = "/ecs/${local.name_prefix}"
  retention_in_days = 30

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-log-group"
    Type = "cloudwatch-log-group"
  })
}