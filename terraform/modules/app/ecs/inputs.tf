
variable "project_identifier" {
  description = "The identifier of the project"
  type        = string
}

variable "container_port" {
  description = "The port on which the container listens"
  type        = number
}

variable "uri_repository" {
  description = "The URI of the container image repository"
  type        = string
}

variable "execution_role_arn" {
  description = "The ARN of the ECS task execution role"
  type        = string

}
