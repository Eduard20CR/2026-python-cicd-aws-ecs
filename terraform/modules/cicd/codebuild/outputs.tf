
output "codebuild_project_arn" {
  description = "ARN of the CodeBuild project"
  value       = aws_codebuild_project.project-using-github-app.arn
}

output "codebuild_project_name" {
  description = "Name of the CodeBuild project"
  value       = aws_codebuild_project.project-using-github-app.name
}

output "codebuild_project_id" {
  description = "ID of the CodeBuild project"
  value       = aws_codebuild_project.project-using-github-app.id
}
