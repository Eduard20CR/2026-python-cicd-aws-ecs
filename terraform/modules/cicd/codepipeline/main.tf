
resource "aws_codepipeline" "codepipeline" {
  name     = "${var.project_identifier}-pipeline"
  role_arn = var.codepipeline_role_arn

  artifact_store {
    location = var.aws_s3_bucket_codepipeline
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        ConnectionArn    = var.aws_codestarconnections_connection
        FullRepositoryId = "Eduard20CR/2026-python-cicd-aws-ecs"
        BranchName       = "main"
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      version          = "1"

      configuration = {
        ProjectName = var.codebuild_project_name
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "ECS"
      input_artifacts = ["build_output"]
      version         = "1"

      configuration = {
        ClusterName = var.aws_ecs_cluster_name
        ServiceName = var.aws_ecs_service_name
        FileName    = "imagedefinitions.json"
      }
    }
  }
}

