
variable "vpc_id" {
  description = "Existing VPC ID"
  type        = string
}

variable "subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "security_group_id" {
  description = "Existing Security Group ID"
  type        = string
}

variable "execution_role_arn" {
  description = "ARN of existing ECS task execution role"
  type        = string
}

variable "container_image" {
  description = "Container image for website"
  type        = string
  default     = "nginx:latest"
}

variable "alb_arn" {
  description = "ARN of existing ALB"
  type        = string
}

variable "desired_count" {
  description = "Number of ECS tasks"
  type        = number
  default     = 1
}
