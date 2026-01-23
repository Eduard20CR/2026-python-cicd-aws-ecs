
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

module "ecs_cluster" {
  source             = "../../modules/app/ecs/cluster"
  project_identifier = local.project_identifier
}
