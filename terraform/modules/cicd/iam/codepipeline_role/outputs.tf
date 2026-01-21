output "codepipeline_role_arn" {
  description = "ARN of the CodePipeline IAM role"
  value       = aws_iam_role.codepipeline.arn
}

output "codepipeline_role_name" {
  description = "Name of the CodePipeline IAM role"
  value       = aws_iam_role.codepipeline.name
}

output "codepipeline_policy_arn" {
  description = "ARN of the CodePipeline IAM policy"
  value       = aws_iam_policy.codepipeline.arn
}
