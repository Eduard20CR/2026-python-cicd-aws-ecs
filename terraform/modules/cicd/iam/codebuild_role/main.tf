data "aws_iam_policy_document" "codebuild_assume" {
  statement {
    actions = "sts:AssumeRole"
    effect  = "Allow"
    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "codebuild" {
  name               = "${var.project_identifier}-codebuild"
  assume_role_policy = data.aws_iam_policy_document.codebuild_assume.json
}


data "aws_iam_policy_document" "codebuild_policy" {

  # ECR permissions
  statement {
    sid       = "ECRAuth"
    actions   = ["ecr:GetAuthorizationToken"]
    resources = ["*"]
  }

  statement {
    sid = "ECRPush"
    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:BatchGetImage",
      "ecr:CompleteLayerUpload",
      "ecr:GetDownloadUrlForLayer",
      "ecr:InitiateLayerUpload",
      "ecr:PutImage",
      "ecr:UploadLayerPart"
    ]
    resources = [var.ecr_repository_arn]
  }

  # CloudWatch Logs permissions
  statement {
    sid       = "CloudWatchLogs"
    actions   = ["logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents"]
    resources = ["*"]
  }

  # S3 bucket-level permissions
  statement {
    sid       = "ArtifactsBucketList"
    actions   = ["s3:ListBucket", "s3:GetBucketLocation"]
    resources = [var.s3_artifacts_arn]
  }

  # S3 object-level permissions
  statement {
    sid = "ArtifactsBucketObjects"
    actions = [
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:PutObject"
    ]
    resources = ["${var.s3_artifacts_arn}/*"]
  }
}

resource "aws_iam_policy" "codebuild" {
  name   = "${var.project_identifier}-codebuild-policy"
  policy = data.aws_iam_policy_document.codebuild_policy.json
}

resource "aws_iam_role_policy_attachment" "codebuild_attach" {
  role       = aws_iam_role.codebuild.name
  policy_arn = aws_iam_policy.codebuild.arn
}
