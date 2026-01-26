
locals {
  project_identifier = "${var.org_name}-${var.project_name}-${var.environment}"
}


module "vpc" {
  source             = "../../modules/vpc"
  project_identifier = local.project_identifier
}

module "ecr_repo" {
  source             = "../../modules/cicd/ecr"
  project_identifier = local.project_identifier
}

module "security_groups" {
  source             = "../../modules/app/security_groups"
  vpc_id             = module.vpc.vpc_id
  project_identifier = local.project_identifier
}

module "iam_app" {
  source             = "../../modules/app/iam/ecs_task_execution_role"
  project_identifier = local.project_identifier
}

module "elb" {
  source             = "../../modules/app/loadbalancer"
  project_identifier = local.project_identifier
  vpc_id             = module.vpc.vpc_id

  security_group_id = module.security_groups.alb_security_group_id
  container_port    = var.container_port
  subnet_ids        = module.vpc.public_subnet_ids
}


module "ecs_cluster" {
  source             = "../../modules/app/ecs/cluster"
  project_identifier = local.project_identifier
}

module "ecs_app_task" {
  source             = "../../modules/app/ecs/task"
  project_identifier = local.project_identifier

  container_port     = var.container_port
  container_app_name = var.container_app_name
  uri_repository     = module.ecr_repo.repository_url
  execution_role_arn = module.iam_app.ecs_task_execution_role_arn
}

module "ecs_service" {
  source             = "../../modules/app/ecs/service"
  project_identifier = local.project_identifier
  cluster_id         = module.ecs_cluster.cluster_id
  private_subnet_ids = module.vpc.private_subnet_ids

  task_definition_arn = module.ecs_app_task.task_definition_arn
  container_app_name  = var.container_app_name
  container_port      = var.container_port
  desired_count       = 0
  service_sg_id       = module.security_groups.alb_security_group_id

  load_balancer_listener_arn     = module.elb.listener_arn
  load_balancer_target_group_arn = module.elb.target_group_arn

  iam_service_role_arn = ""
}
