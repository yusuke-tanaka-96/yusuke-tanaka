data "aws_iam_policy_document" "s3_cwlogs_backup_bucket_policy" {
  statement {
    sid    = "AllowNLBAccessLogsToPutObjects"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["delivery.logs.amazonaws.com"]
    }
    actions = ["s3:PutObject"]
    resources = [
      "arn:aws:s3:::${module.s3-cloudwatch-logs-backup.bucket_name}/*"
    ]
  }
}

module "s3-cloudwatch-logs-backup" {
  source        = "../../modules/s3"
  bucket_name   = "${local.name_prefix}-cloudwatch-logs-backup-${local.aws_account}"
  name_prefix   = local.name_prefix
  merged_tags   = local.merged_tags
  bucket_policy = data.aws_iam_policy_document.s3_cwlogs_backup_bucket_policy.json

  versioning_enabled    = false
  enable_object_lock    = false
  server_access_logging = false
}

data "aws_iam_policy_document" "s3_logs_bucket_policy" {
  statement {
    sid    = "AllowAllEverything"
    effect = "Allow"
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    actions = ["s3:*"]
    resources = [
      "arn:aws:s3:::${module.s3-logs-bucket-replication.bucket_name}",
      "arn:aws:s3:::${module.s3-logs-bucket-replication.bucket_name}/*"
    ]
  }


  # CloudTrail用のステートメント
  statement {
    sid    = "AWSCloudTrailAclCheck"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
    actions   = ["s3:GetBucketAcl"]
    resources = [module.s3-logs-bucket-replication.bucket_arn]
  }

  statement {
    sid    = "AWSCloudTrailWrite"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
    actions   = ["s3:PutObject"]
    resources = ["${module.s3-logs-bucket-replication.bucket_arn}/test1/AWSLogs/${data.aws_caller_identity.current.account_id}/*"]
    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
  }

  # WAF用のステートメント
  statement {
    sid    = "AllowWAFServiceToPutLogs"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["waf.amazonaws.com"]
    }
    actions   = ["s3:PutObject"]
    resources = ["${module.s3-logs-bucket-replication.bucket_arn}/*"]
    condition {
      test     = "StringEquals"
      variable = "aws:SourceAccount"
      values   = [data.aws_caller_identity.current.account_id]
    }
  }

  # GuardDuty用のステートメント
  statement {
    sid    = "AWSGuardDutyWrite"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["guardduty.amazonaws.com"]
    }
    actions   = ["s3:PutObject"]
    resources = ["${module.s3-logs-bucket-replication.bucket_arn}/test1/AWSLogs/${data.aws_caller_identity.current.account_id}/*"]
    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
  }

  # GuardDuty用の追加ステートメント（ARN条件付き）
  statement {
    sid    = "AllowGuardDutyServiceToWrite"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["guardduty.amazonaws.com"]
    }
    actions   = ["s3:PutObject"]
    resources = ["${module.s3-logs-bucket-replication.bucket_arn}/*"]
    condition {
      test     = "StringEquals"
      variable = "aws:SourceAccount"
      values   = [data.aws_caller_identity.current.account_id]
    }
    condition {
      test     = "ArnLike"
      variable = "aws:SourceArn"
      values   = ["arn:aws:guardduty:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:detector/*"]
    }
  }

  statement {
    sid    = "AllowGuardDutyGetBucketLocation"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["guardduty.amazonaws.com"]
    }
    actions   = ["s3:GetBucketLocation"]
    resources = [module.s3-logs-bucket-replication.bucket_arn]
    condition {
      test     = "StringEquals"
      variable = "aws:SourceAccount"
      values   = [data.aws_caller_identity.current.account_id]
    }
  }


  # S3ログ配信用のバケットポリシー
  statement {
    sid    = "S3ServerAccessLogsPolicy"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
    actions   = ["s3:PutObject"]
    resources = ["arn:aws:s3:::${module.s3-logs-bucket-replication.bucket_name}/S3AccessLogs/*"]
    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
  }

  statement {
    sid    = "S3PolicyStmt-DO-NOT-MODIFY-1751009831602"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["logging.s3.amazonaws.com"]
    }
    actions   = ["s3:PutObject"]
    resources = ["${module.s3-logs-bucket-replication.bucket_arn}/*"]
    condition {
      test     = "StringEquals"
      variable = "aws:SourceAccount"
      values   = [data.aws_caller_identity.current.account_id]
    }
  }

}
