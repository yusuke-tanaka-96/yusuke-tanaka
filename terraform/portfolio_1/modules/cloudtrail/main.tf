resource "aws_cloudtrail" "this" {
  name                          = "${var.name_prefix}-cloudtrail"
  s3_bucket_name                = var.s3_bucket_name
  s3_key_prefix                 = var.s3_key_prefix # ディレクトリ変更
  include_global_service_events = var.include_global_service_events
  is_multi_region_trail         = var.is_multi_region_trail
  enable_logging                = var.enable_logging
  enable_log_file_validation    = var.enable_log_file_validation
  kms_key_id                    = var.kms_key_id != "" ? var.kms_key_id : null
  cloud_watch_logs_role_arn     = var.cloudwatch_log_group_arn != "" ? var.cloudwatch_role_arn : null
  cloud_watch_logs_group_arn    = var.cloudwatch_log_group_arn != "" ? var.cloudwatch_log_group_arn : null
  tags                          = var.merged_tags

  event_selector {
    read_write_type           = var.event_selector_read_write_type
    include_management_events = var.include_management_events

    data_resource {
      type   = "AWS::S3::Object"
      values = [for b in var.s3_data_event_buckets : "arn:aws:s3:::${b}/"]
    }
  }
}
