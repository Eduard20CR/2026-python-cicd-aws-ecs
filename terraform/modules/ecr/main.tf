resource "aws_ecr_repository" "this" {
  name                 = "${var.org_name}/${var.project_name}-${var.environment}-app-repository"
  image_tag_mutability = "IMMUTABLE"
  force_delete         = true
}
