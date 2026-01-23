locals {

  container_definitions = [
    {
      name      = "app"
      image     = var.uri_repository
      essential = true

      environment = [
        {
          name  = "ENVIRONMENT"
          value = "test"
        }
      ]

      portMappings = [
        {
          name          = "app-${var.container_port}-tcp"
          containerPort = var.container_port
          protocol      = "tcp"
          appProtocol   = "http"
        }
      ]
    }
  ]
}

resource "aws_ecs_task_definition" "this" {
  family                = "${var.project_identifier}-task"
  container_definitions = jsonencode(local.container_definitions)

  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"

  cpu    = var.task_cpu
  memory = var.task_memory

  execution_role_arn = var.execution_role_arn
  # task_role_arn    = var.task_role_arn 

  ephemeral_storage {
    size_in_gib = var.ephemeral_storage_gib
  }

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = var.cpu_architecture
  }
}
