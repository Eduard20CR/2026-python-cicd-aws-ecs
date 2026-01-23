
variable "project_identifier" {
  description = "The identifier of the project"
  type        = string
}

variable "cluster_id" {
  description = "The ECS cluster ID"
  type        = string
}

variable "desired_count" {
  description = "The desired number of ECS service instances"
  type        = number
}

variable "task_definition_arn" {
  description = "The ARN of the ECS task definition"
  type        = string
}

variable "iam_role_arn" {
  description = "The ARN of the IAM role for the ECS service"
  type        = string
}

variable "load_balancer_listener_arn" {
  description = "The ARN of the load balancer listener"
  type        = string
}

variable "load_balancer_target_group_arn" {
  description = "The ARN of the load balancer target group"
  type        = string
}

variable "container_app_name" {
  description = "The name of the application container"
  type        = string
}

variable "container_port" {
  description = "The port on the container"
  type        = number
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for the ECS service"
  type        = list(string)
}

variable "service_sg_id" {
  description = "The security group ID for the ECS service"
  type        = string
}




