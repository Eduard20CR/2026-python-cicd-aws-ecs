variable "project_identifier" {
  description = "The identifier of the project"
  type        = string
}


variable "ecr_repository_arn" {
  description = "The ARN of the ECR repository"
  type        = string
}


variable "s3_artifacts_arn" {
  description = "The ARN of the S3 bucket for artifacts"
  type        = string
}
