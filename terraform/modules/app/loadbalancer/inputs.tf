
variable "project_identifier" {
  description = "The identifier of the project"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC where the security groups will be created"
  type        = string
}

variable "security_group_id" {
  description = "The ID of the security group to associate with the load balancer"
  type        = string
}

variable "subnet_ids" {
  description = "A list of subnet IDs to attach to the load balancer"
  type        = list(string)
}

variable "container_port" {
  description = "The port on which the container is listening"
  type        = number
}
