variable "execution_role_arn" {
  description = "ARN of existing ECS task execution role"
  type        = string
}

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