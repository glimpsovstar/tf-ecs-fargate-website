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