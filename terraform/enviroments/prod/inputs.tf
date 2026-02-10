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
  default     = 8000
}

variable "container_app_name" {
  description = "The name of the application container"
  type        = string
  default     = "cronos-app"
}


variable "codeconnections_arn" {
  description = "The ARN of the CodeStar Connections connection"
  type        = string
  default     = "arn:aws:codeconnections:us-east-1:058264166152:connection/2269c483-60c9-415f-9bae-29a030ecb1b7"
}
