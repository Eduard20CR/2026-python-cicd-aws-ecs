output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.default_vpc_id
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = module.vpc.default_vpc_cidr_block
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = module.vpc.public_subnets
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = module.vpc.private_subnets
}

output "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  value       = module.vpc.igw_id
}
