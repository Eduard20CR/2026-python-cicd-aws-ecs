variable "org_name" {
  description = "The name of the organization"
  type        = string
  default     = "scarus"
}

variable "project_name" {
  description = "The name of the project"
  type        = string
  default     = "cronos"
}

variable "environment" {
  description = "The deployment environment"
  type        = string
  default     = "prod"
}

variable "container_port" {
  description = "The port on the container"
  type        = number
  default     = 80
}

variable "container_app_name" {
  description = "The name of the application container"
  type        = string
  default     = "cronos-app"
}
