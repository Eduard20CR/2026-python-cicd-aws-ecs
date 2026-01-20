
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${var.org_name}-${var.project_name}-${var.environment}-vpc"
  cidr = var.cidr_block

  azs             = var.azs
  private_subnets = var.private_subnets_cidr
  public_subnets  = var.public_subnets_cidr
}
