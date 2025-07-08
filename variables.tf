variable "container_image" {
  description = "Container image for website"
  type        = string
  default     = "nginx:latest"
}

variable "desired_count" {
  description = "Number of ECS tasks"
  type        = number
  default     = 1
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-southeast-2"
}

variable "domain_name" {
  description = "Domain name for the website"
  type        = string
  default     = "david-joo.sbx.hashidemos.io"
}

# New variables for better demo and tagging
variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "meow-website"
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "owner" {
  description = "Owner of the resources"
  type        = string
  default     = "terraform-demo"
}

variable "cost_center" {
  description = "Cost center for billing"
  type        = string
  default     = "engineering"
}

variable "repository" {
  description = "Source code repository"
  type        = string
  default     = "terraform-ecs-demo"
}

# Local values for consistent tagging and naming
locals {
  # Existing remote state references
  vpc_id            = data.terraform_remote_state.network.outputs.vpc_id
  subnet_ids        = data.terraform_remote_state.network.outputs.vpc_public_subnets
  security_group_id = data.terraform_remote_state.network.outputs.security_group-ssh_http_https_allowed
  execution_role_arn = data.terraform_remote_state.aws_role.outputs.role_arn
  
  # Common naming prefix
  name_prefix = "${var.project_name}-${var.environment}"
  
  # Comprehensive tags for TFC demo
  common_tags = {
    Name               = local.name_prefix
    Environment        = var.environment
    Project            = var.project_name
    Owner              = var.owner
    CostCenter         = var.cost_center
    TerraformManaged   = "true"
    TerraformWorkspace = "tf-ecs-fargate-website"
    CreatedBy          = "terraform-cloud"
    Repository         = var.repository
    Region             = var.aws_region
    LastUpdated        = timestamp()
    # Custom tags for demo purposes
    Application        = "web-frontend"
    Tier              = "presentation"
    BackupRequired    = "false"
    MonitoringEnabled = "true"
  }
}