
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${var.project_identifier}-vpc"
  cidr = var.cidr_block

  azs             = var.azs
  private_subnets = var.private_subnets_cidr
  public_subnets  = var.public_subnets_cidr

  enable_nat_gateway = true
  single_nat_gateway = true
}
