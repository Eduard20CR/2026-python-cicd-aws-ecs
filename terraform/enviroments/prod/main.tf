module "vpc" {
  source = "../../modules/vpc"
}

module "ecr_repo" {
  source = "../../modules/ecr"
}

module "security_groups" {
  source = "../../modules/security_groups"
  vpc_id = module.vpc.vpc_id
}
