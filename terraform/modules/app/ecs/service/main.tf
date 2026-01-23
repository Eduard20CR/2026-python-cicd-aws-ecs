
resource "aws_ecs_service" "this" {
  name                   = "${var.project_identifier}-app-service"
  cluster                = var.cluster_id
  task_definition        = var.task_definition_arn
  desired_count          = var.desired_count
  depends_on             = [var.load_balancer_listener_arn]
  enable_execute_command = true

  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200

  deployment_circuit_breaker {
    enable   = true
    rollback = true
  }

  health_check_grace_period_seconds = 60

  load_balancer {
    target_group_arn = var.load_balancer_target_group_arn
    container_name   = var.container_app_name
    container_port   = var.container_port
  }

  network_configuration {
    subnets          = var.private_subnet_ids
    security_groups  = [var.service_sg_id]
    assign_public_ip = false
  }
}
