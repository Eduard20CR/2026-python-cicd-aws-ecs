# ECS Cluster

resource "aws_ecs_cluster" "this" {
  name = "${var.project_identifier}-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_cluster_capacity_providers" "this" {
  cluster_name = aws_ecs_cluster.this.name

  capacity_providers = ["FARGATE", "FARGATE_SPOT"]

  default_capacity_provider_strategy {
    capacity_provider = "FARGATE"
    base              = 1
    weight            = 1
  }

  default_capacity_provider_strategy {
    capacity_provider = "FARGATE_SPOT"
    weight            = 2
  }
}

# Task Definition

locals {

  container_definitions = [
    {
      name      = "app"
      image     = var.uri_repository
      cpu       = 0
      essential = true

      portMappings = [
        {
          name          = "app-${var.container_port}-tcp"
          containerPort = var.container_port
          hostPort      = var.container_port
          protocol      = "tcp"
          appProtocol   = "http"
        }
      ]
    }
  ]
}

resource "aws_ecs_task_definition" "service" {
  family                = "service"
  container_definitions = jsonencode(local.container_definitions)

  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"

  cpu    = "1024"
  memory = "2048"

  # Execution role como en tu JSON
  execution_role_arn = var.execution_role_arn
  # task_role_arn    = var.task_role_arn 

  ephemeral_storage {
    size_in_gib = 21
  }

  # runtimePlatform (Linux + x86_64)
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
}
