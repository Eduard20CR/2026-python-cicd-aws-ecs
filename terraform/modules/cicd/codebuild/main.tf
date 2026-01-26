resource "aws_codebuild_project" "project-using-github-app" {
  name         = "${var.project_identifier}-codebuild-project"
  description  = "Example CodeBuild Project"
  service_role = var.codebuild_service_role_arn

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:4.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = true
  }

  source { type = "CODEPIPELINE" }
  artifacts { type = "CODEPIPELINE" }

  logs_config {
    cloudwatch_logs {
      status = "ENABLED"
    }
  }
}
