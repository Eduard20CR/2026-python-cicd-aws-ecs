
variable "project_identifier" {
  description = "The identifier of the project"
  type        = string
  default     = "cronos"
}

variable "vpc_id" {
  description = "The ID of the VPC where the security groups will be created"
  type        = string
}
