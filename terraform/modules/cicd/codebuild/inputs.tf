variable "project_identifier" {
  description = "The identifier of the project"
  type        = string
}

variable "codebuild_service_role_arn" {
  description = "The ARN of the IAM role that CodeBuild will use"
  type        = string
}


variable "image_repo_name" {
  description = "The name of the ECR repository to push the built image to"
  type        = string
}

variable "aws_account_id" {
  description = "The AWS account ID where the ECR repository is located"
  type        = string
}

variable "aws_default_region" {
  description = "The AWS region where the ECR repository is located"
  type        = string
}

variable "task_definition_app_name" {
  description = "The name of the application in the task definition"
  type        = string
}
