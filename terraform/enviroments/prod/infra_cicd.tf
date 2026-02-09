data "aws_codestarconnections_connection" "this" {
  arn = var.codeconnections_arn
}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

module "s3_cicd" {
  source             = "../../modules/cicd/s3"
  project_identifier = local.project_identifier
}


module "codebuild_role_cicd" {
  source             = "../../modules/cicd/iam/codebuild_role"
  project_identifier = local.project_identifier
  ecr_repository_arn = module.ecr_repo.arn
  s3_artifacts_arn   = module.s3_cicd.bucket_arn
}

module "codebuild_cicd" {
  source                     = "../../modules/cicd/codebuild"
  project_identifier         = local.project_identifier
  codebuild_service_role_arn = module.codebuild_role_cicd.codebuild_role_arn

  aws_account_id           = data.aws_caller_identity.current.account_id
  aws_default_region       = data.aws_region.current.region
  image_repo_name          = module.ecr_repo.repository_name
  task_definition_app_name = var.container_app_name
}

module "codepipeline_role_cicd" {
  source                  = "../../modules/cicd/iam/codepipeline_role"
  project_identifier      = local.project_identifier
  codebuild_project_arn   = module.codebuild_cicd.codebuild_project_arn
  s3_artifacts_arn        = module.s3_cicd.bucket_arn
  codestar_connection_arn = data.aws_codestarconnections_connection.this.arn

  ecs_task_role_arn           = module.iam_app_role.task_role_arn
  ecs_task_execution_role_arn = module.iam_task_executions_app_role.ecs_task_execution_role_arn

}

module "codepipeline_cicd" {
  source             = "../../modules/cicd/codepipeline"
  project_identifier = local.project_identifier

  aws_codestarconnections_connection = data.aws_codestarconnections_connection.this.arn
  aws_ecs_cluster_name               = module.ecs_cluster.cluster_name
  aws_ecs_service_name               = module.ecs_service.service_name
  aws_s3_bucket_codepipeline         = module.s3_cicd.bucket_name
  codebuild_project_name             = module.codebuild_cicd.codebuild_project_name
  codepipeline_role_arn              = module.codepipeline_role_cicd.codepipeline_role_arn
}
