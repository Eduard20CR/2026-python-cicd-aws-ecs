
variable "project_identifier" {
  description = "The identifier of the project"
  type        = string
}

variable "codepipeline_role_arn" {
  description = "The ARN of the IAM role for CodePipeline"
  type        = string
}


variable "aws_s3_bucket_codepipeline" {
  description = "The name of the S3 bucket for CodePipeline artifacts"
  type        = string
}

variable "aws_codestarconnections_connection" {
  description = "The ARN of the CodeStar Connections connection"
  type        = string
}


variable "codebuild_project_name" {
  description = "The name of the CodeBuild project"
  type        = string
}

variable "aws_ecs_cluster_name" {
  description = "The name of the ECS cluster"
  type        = string
}

variable "aws_ecs_service_name" {
  description = "The name of the ECS service"
  type        = string
}
