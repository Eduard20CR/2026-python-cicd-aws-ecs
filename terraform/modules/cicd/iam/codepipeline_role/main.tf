

data "aws_iam_policy_document" "ecs_task_execution_assume" {
  statement {
    actions = "sts:AssumeRole"
    effect  = "Allow"
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs_task_execution" {
  name               = "${var.project_identifier}-ecs-task-exec"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_execution_assume.json
}
