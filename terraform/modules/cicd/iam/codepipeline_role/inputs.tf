variable "project_identifier" {
  description = "The identifier of the project"
  type        = string
}

variable "s3_artifacts_arn" {
  description = "The ARN of the S3 bucket for artifacts"
  type        = string
}

variable "codestar_connection_arn" {
  description = "The ARN of the CodeStar Connection (for GitHub)"
  type        = string
}

variable "codebuild_project_arn" {
  description = "The ARN of the CodeBuild project"
  type        = string
}

variable "ecs_task_execution_role_arn" {
  description = "The ARN of the ECS task execution role"
  type        = string
}

variable "ecs_task_role_arn" {
  description = "The ARN of the ECS task role"
  type        = string
}
