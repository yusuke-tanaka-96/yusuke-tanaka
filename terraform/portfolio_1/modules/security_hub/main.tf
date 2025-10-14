resource "aws_securityhub_account" "this" {
  enable_default_standards  = var.enable_default_standards
  control_finding_generator = var.control_finding_generator
  auto_enable_controls      = var.auto_enable_controls
}

resource "aws_securityhub_standards_subscription" "this" {
  for_each = toset(var.standards_arns)

  standards_arn = each.value
  depends_on    = [aws_securityhub_account.this]
}

resource "aws_securityhub_finding_aggregator" "this" {
  count = var.enable_finding_aggregator ? 1 : 0

  linking_mode      = var.aggregator_linking_mode
  specified_regions = var.aggregator_regions
  depends_on        = [aws_securityhub_account.this]
}