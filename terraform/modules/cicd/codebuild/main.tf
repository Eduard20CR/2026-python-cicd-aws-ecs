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


    environment_variable {
      name  = "IMAGE_REPO_NAME"
      value = var.image_repo_name
    }

    environment_variable {
      name  = "AWS_ACCOUNT_ID"
      value = var.aws_account_id
    }

    environment_variable {
      name  = "AWS_DEFAULT_REGION"
      value = var.aws_default_region
    }

    environment_variable {
      name  = "TASK_DEFINITION_APP_NAME"
      value = var.task_definition_app_name
    }
  }



  source { type = "CODEPIPELINE" }
  artifacts { type = "CODEPIPELINE" }

  logs_config {
    cloudwatch_logs {
      status = "ENABLED"
    }
  }
}
