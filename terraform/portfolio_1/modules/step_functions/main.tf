resource "aws_cloudwatch_log_group" "sfn_logs" {
  count             = var.enable_logging ? 1 : 0
  name              = "/aws/vendedlogs/states/${var.name_prefix}-${var.name_suffix}"
  retention_in_days = var.log_retention_days
  tags              = var.merged_tags
}

resource "aws_sfn_state_machine" "this" {
  name       = "${var.name_prefix}-${var.name_suffix}"
  role_arn   = var.role_arn
  definition = var.definition
  type       = var.state_machine_type

  dynamic "logging_configuration" {
    for_each = var.enable_logging ? [1] : []
    content {
      log_destination        = "${aws_cloudwatch_log_group.sfn_logs[0].arn}:*"
      include_execution_data = var.include_execution_data
      level                  = var.log_level
    }
  }

  tags = var.merged_tags
}
