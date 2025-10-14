resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name

  # acl = "private" # パブリックアクセスはブロック

  tags = merge(var.merged_tags, {
    Name = "${var.name_prefix}-${var.name_suffix}"
  })
}

resource "aws_s3_bucket_ownership_controls" "this" {
  count  = var.object_ownership != "" ? 1 : 0
  bucket = aws_s3_bucket.this.id

  rule {
    object_ownership = var.object_ownership
  }
}

# S3バケット内にフォルダを作成
resource "aws_s3_object" "folder" {
  count  = var.folder_name != "" ? 1 : 0
  bucket = aws_s3_bucket.this.id
  key    = "${var.folder_name}/"
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status = var.versioning_enabled ? "Enabled" : "Suspended"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = true
  }
}

# デフォルトの HTTPS 制限ポリシー
data "aws_iam_policy_document" "https_only" {
  statement {
    sid    = "AllowSSLRequestsOnly"
    effect = "Deny"
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    actions = [
      "s3:*"
    ]
    resources = [
      "${aws_s3_bucket.this.arn}",
      "${aws_s3_bucket.this.arn}/*"
    ]
    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = ["false"]
    }
  }
}

# ユーザー指定の追加ポリシーをマージ
data "aws_iam_policy_document" "merged" {
  source_policy_documents   = [data.aws_iam_policy_document.https_only.json]
  override_policy_documents = var.bucket_policy != "" ? [var.bucket_policy, data.aws_iam_policy_document.https_only.json] : []
}

resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.this.id
  policy = data.aws_iam_policy_document.merged.json
}

# デフォルトのライフサイクルルール
locals {
  default_lifecycle_rules = [
    {
      id                        = "expire-after-1year"
      status                    = "Enabled"
      prefix                    = ""
      expiration_days           = 365
      newer_noncurrent_versions = null
      noncurrent_days           = null
    }
  ]

  # ユーザー指定のルールがある場合はそれを使用、ない場合はデフォルトを使用
  final_lifecycle_rules = length(var.lifecycle_rules) > 0 ? var.lifecycle_rules : local.default_lifecycle_rules
}

resource "aws_s3_bucket_lifecycle_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  dynamic "rule" {
    for_each = local.final_lifecycle_rules
    content {
      id     = rule.value.id
      status = rule.value.status
      filter {
        prefix = rule.value.prefix
      }
      dynamic "expiration" {
        for_each = rule.value.expiration_days != null ? [1] : []
        content {
          days = rule.value.expiration_days
        }
      }

      dynamic "noncurrent_version_expiration" {
        for_each = rule.value.newer_noncurrent_versions != null || rule.value.noncurrent_days != null ? [1] : []
        content {
          newer_noncurrent_versions = rule.value.newer_noncurrent_versions
          noncurrent_days           = rule.value.noncurrent_days
        }
      }
    }
  }
}


resource "aws_s3_bucket_logging" "this" {
  count  = var.server_access_logging ? 1 : 0
  bucket = aws_s3_bucket.this.id

  target_bucket = aws_s3_bucket.this.id
  target_prefix = var.access_log_prefix

  dynamic "target_object_key_format" {
    for_each = var.enable_partitioned_logging ? [1] : []
    content {
      partitioned_prefix {
        partition_date_source = "EventTime"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

