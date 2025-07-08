
# ECS Fargate Website Module

This Terraform module deploys a simple website using ECS Fargate, attached to an existing VPC, subnets, security group, and ALB.

## Files

- `variables.tf` — Variables for VPC, subnets, IAM role, ALB, etc.
- `ecs_cluster.tf` — ECS Cluster definition.
- `ecs_task_definition.tf` — Fargate task definition.
- `alb.tf` — ALB target group and listener.
- `ecs_service.tf` — ECS Fargate service attached to ALB.
- `terraform.tfvars.example` — Example values to configure your environment.

