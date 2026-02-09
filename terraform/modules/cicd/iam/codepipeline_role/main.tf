data "aws_iam_policy_document" "codepipeline_assume" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["codepipeline.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "codepipeline" {
  name               = "${var.project_identifier}-codepipeline"
  assume_role_policy = data.aws_iam_policy_document.codepipeline_assume.json
}

data "aws_iam_policy_document" "codepipeline_policy" {
  # Artifacts en S3
  statement {
    sid       = "ArtifactsBucketList"
    effect    = "Allow"
    actions   = ["s3:ListBucket", "s3:GetBucketLocation"]
    resources = [var.s3_artifacts_arn]
  }

  statement {
    sid    = "ArtifactsBucketObjects2"
    effect = "Allow"
    actions = [
      "s3:GetBucketVersioning",
      "s3:GetBucketAcl",
      "s3:GetBucketLocation"
    ]
    resources = [var.s3_artifacts_arn]
  }

  statement {
    sid    = "ArtifactsBucketObjects"
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:PutObject",
      "s3:PutObjectAcl"
    ]
    resources = ["${var.s3_artifacts_arn}/*"]
  }

  # Invocar CodeBuild
  statement {
    sid    = "CodeBuild"
    effect = "Allow"
    actions = [
      "codebuild:BatchGetBuilds",
      "codebuild:StartBuild",
      "codebuild:BatchGetBuildBatches",
      "codebuild:StartBuildBatch"
    ]
    resources = [var.codebuild_project_arn]
  }

  # Si usas CodeStar Connections (GitHub)
  statement {
    sid    = "CodeStarConnections"
    effect = "Allow"
    actions = [
      "codestar-connections:UseConnection"

    ]
    resources = [var.codestar_connection_arn]
  }

  # ECS deploy
  statement {
    sid    = "ECSRollingDeploy"
    effect = "Allow"
    actions = [
      "ecs:DescribeClusters",
      "ecs:DescribeServices",
      "ecs:DescribeTaskDefinition",
      "ecs:RegisterTaskDefinition",
      "ecs:UpdateService"
    ]
    resources = ["*"]
  }

  # PassRole: el más común punto de falla
  statement {
    sid     = "PassRoleToECSOrCodeDeploy"
    actions = ["iam:PassRole"]
    effect  = "Allow"
    resources = [
      var.ecs_task_execution_role_arn,
      var.ecs_task_role_arn
    ]

    condition {
      test     = "StringEquals"
      variable = "iam:PassedToService"
      values = [
        "ecs.amazonaws.com",
        "ecs-tasks.amazonaws.com"
      ]
    }
  }
}

resource "aws_iam_policy" "codepipeline" {
  name   = "${var.project_identifier}-codepipeline-policy"
  policy = data.aws_iam_policy_document.codepipeline_policy.json
}

resource "aws_iam_role_policy_attachment" "codepipeline_attach" {
  role       = aws_iam_role.codepipeline.name
  policy_arn = aws_iam_policy.codepipeline.arn
}
