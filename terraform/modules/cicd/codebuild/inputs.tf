variable "project_identifier" {
  description = "The identifier of the project"
  type        = string
}

variable "codebuild_service_role_arn" {
  description = "The ARN of the IAM role that CodeBuild will use"
  type        = string
}
