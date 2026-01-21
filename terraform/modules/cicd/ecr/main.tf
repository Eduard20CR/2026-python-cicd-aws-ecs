resource "aws_ecr_repository" "this" {
  name                 = "${var.project_identifier}-app-repository"
  image_tag_mutability = "IMMUTABLE"
  force_delete         = true
}
