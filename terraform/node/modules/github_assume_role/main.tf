data "aws_caller_identity" "current" {}

locals {
  default_oidc_provider_arn   = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/token.actions.githubusercontent.com"
  effective_oidc_provider_arn = var.oidc_provider_arn != null ? var.oidc_provider_arn : local.default_oidc_provider_arn
}

resource "aws_iam_role" "github_actions" {
  name = var.role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = local.effective_oidc_provider_arn
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringLike = {
            "token.actions.githubusercontent.com:sub" = [
              for repo in var.github_repositories :
              "repo:${repo}:*"
            ]
          }
        }
      }
    ]
  })

  tags = merge(var.merged_tags, {
    Name = var.role_name
  })
}

resource "aws_iam_role_policy" "inline" {
  count  = var.inline_policy_json != null ? 1 : 0
  name   = "${var.role_name}-inline"
  role   = aws_iam_role.github_actions.id
  policy = var.inline_policy_json
}
