output "alb_security_group_id" {
  description = "ID of the ALB security group"
  value       = aws_security_group.alb.id
}

output "alb_security_group_arn" {
  description = "ARN of the ALB security group"
  value       = aws_security_group.alb.arn
}

output "app_security_group_id" {
  description = "ID of the app security group"
  value       = aws_security_group.app.id
}

output "app_security_group_arn" {
  description = "ARN of the app security group"
  value       = aws_security_group.app.arn
}
