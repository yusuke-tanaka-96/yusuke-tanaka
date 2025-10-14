locals {
  module_enabled    = var.enabled
  use_schedule_rule = local.module_enabled && var.schedule_expression != null
  use_event_rule    = local.module_enabled && var.event_pattern != null
}

resource "aws_cloudwatch_event_bus" "this" {
  count = local.module_enabled && var.event_bus_name != "" ? 1 : 0
  name  = var.event_bus_name
  tags  = var.merged_tags

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_cloudwatch_event_rule" "schedule" {
  count               = local.use_schedule_rule ? 1 : 0
  name                = "${var.name_prefix}-${var.name_rule}"
  schedule_expression = var.schedule_expression
  tags                = var.merged_tags
}

resource "aws_cloudwatch_event_rule" "event" {
  count = local.use_event_rule ? 1 : 0

  name          = "${var.name_prefix}-${var.name_rule}"
  event_pattern = var.event_pattern
  tags          = var.merged_tags
}

resource "aws_cloudwatch_event_target" "this" {
  count = local.module_enabled ? 1 : 0

  rule = coalesce(
    try(aws_cloudwatch_event_rule.schedule[0].name, null),
    try(aws_cloudwatch_event_rule.event[0].name, null)
  )
  arn      = var.target_arn
  role_arn = var.role_arn

  input = jsonencode({
    projectName = var.project_name
  })
}

resource "aws_lambda_permission" "this" {
  count = local.module_enabled && var.lambda_function_name != "" ? 1 : 0

  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  principal     = "events.amazonaws.com"
  function_name = var.lambda_function_name
  source_arn = coalesce(
    try(aws_cloudwatch_event_rule.schedule[0].arn, null),
    try(aws_cloudwatch_event_rule.event[0].arn, null),
    null
  )
}
