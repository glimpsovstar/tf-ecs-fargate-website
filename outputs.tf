output "load_balancer_dns" {
  description = "DNS name of the load balancer"
  value       = aws_lb.website.dns_name
}

output "load_balancer_url" {
  description = "URL to access the application via ALB"
  value       = "http://${aws_lb.website.dns_name}"
}

output "custom_domain_url" {
  description = "URL to access the application via custom domain"
  value       = "http://website.david-joo.sbx.hashidemos.io"
}

output "domain_name" {
  description = "Custom domain name"
  value       = "website.david-joo.sbx.hashidemos.io"
}

output "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  value       = aws_ecs_cluster.website.name
}

output "ecs_service_name" {
  description = "Name of the ECS service"
  value       = aws_ecs_service.website.name
}

output "task_definition_arn" {
  description = "ARN of the task definition"
  value       = aws_ecs_task_definition.website.arn
}

output "target_group_arn" {
  description = "ARN of the target group"
  value       = aws_lb_target_group.website.arn
}

output "cloudwatch_log_group" {
  description = "CloudWatch log group for ECS tasks"
  value       = aws_cloudwatch_log_group.website.name
}

# Demo-specific outputs
output "demo_info" {
  description = "Information for demo purposes"
  value = {
    project_name = var.project_name
    environment  = var.environment
    region       = var.aws_region
    owner        = var.owner
    cost_center  = var.cost_center
    repository   = var.repository
  }
}