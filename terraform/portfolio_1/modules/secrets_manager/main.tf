resource "aws_secretsmanager_secret" "this" {
  name        = "${var.name_prefix}-${var.name_suffix}"
  description = var.description
  tags        = var.merged_tags
}

resource "aws_secretsmanager_secret_version" "this" {
  secret_id     = aws_secretsmanager_secret.this.id
  secret_string = var.secret_string

  lifecycle {
    # JSON中身の変更を丸ごと無視
    ignore_changes = [secret_string]
  }
}

resource "aws_secretsmanager_secret_rotation" "this" {
  count               = var.rotation_lambda_arn != "" ? 1 : 0
  secret_id           = aws_secretsmanager_secret.this.id
  rotation_lambda_arn = var.rotation_lambda_arn

  rotation_rules {
    automatically_after_days = var.rotation_days
  }
  # 初回バージョンがないとエラーになるため依存関係を明示
  depends_on = [aws_secretsmanager_secret_version.this]

  lifecycle {
    # ルール一式の差分を全部無視
    ignore_changes = [rotation_rules]
  }
}
