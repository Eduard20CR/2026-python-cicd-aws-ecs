
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

variable "task_cpu" {
  description = "The amount of CPU to allocate to the task"
  type        = string
  default     = "1024"

}

variable "task_memory" {
  description = "The amount of memory to allocate to the task"
  type        = string
  default     = "2048"
}


variable "ephemeral_storage_gib" {
  description = "The size of ephemeral storage for the task in GiB"
  type        = number
  default     = 21
}

variable "cpu_architecture" {
  description = "The CPU architecture for the task"
  type        = string
  default     = "X86_64"
}
