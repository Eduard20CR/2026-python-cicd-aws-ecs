output "service_id" {
  description = "The ID of the ECS service"
  value       = aws_ecs_service.this.id
}

output "service_name" {
  description = "The name of the ECS service"
  value       = aws_ecs_service.this.name
}

output "service_arn" {
  description = "The ARN of the ECS service"
  value       = aws_ecs_service.this.arn
}

output "service_cluster" {
  description = "The cluster of the ECS service"
  value       = aws_ecs_service.this.cluster
}

output "service_desired_count" {
  description = "The desired count of tasks for the ECS service"
  value       = aws_ecs_service.this.desired_count
}
