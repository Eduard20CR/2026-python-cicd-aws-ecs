resource "aws_ecr_repository" "this" {
  name                 = var.repo_name
  image_tag_mutability = "IMMUTABLE"
  force_delete         = true
}
