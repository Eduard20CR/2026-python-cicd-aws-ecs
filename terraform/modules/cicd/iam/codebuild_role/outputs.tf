output "codebuild_role_arn" {
  description = "ARN of the CodeBuild IAM role"
  value       = aws_iam_role.codebuild.arn
}

output "codebuild_role_name" {
  description = "Name of the CodeBuild IAM role"
  value       = aws_iam_role.codebuild.name
}

output "codebuild_policy_arn" {
  description = "ARN of the CodeBuild IAM policy"
  value       = aws_iam_policy.codebuild.arn
}
