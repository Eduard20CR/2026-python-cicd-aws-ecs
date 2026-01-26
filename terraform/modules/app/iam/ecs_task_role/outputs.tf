
output "task_role_arn" {
  description = "ARN of the ECS task IAM role"
  value       = aws_iam_role.task_role.arn
}

output "task_role_name" {
  description = "Name of the ECS task IAM role"
  value       = aws_iam_role.task_role.name
}

output "task_role_id" {
  description = "ID of the ECS task IAM role"
  value       = aws_iam_role.task_role.id
}
