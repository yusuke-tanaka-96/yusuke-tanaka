output "securityhub_account_id" {
  description = "ID of the Security Hub account"
  value       = aws_securityhub_account.this.id
}

output "standards_subscription_arns" {
  description = "List of ARNs for subscribed Security Hub standards"
  value       = [for sub in aws_securityhub_standards_subscription.this : sub.standards_arn]
}

output "finding_aggregator_id" {
  description = "ID of the Security Hub finding aggregator (if enabled)"
  value       = var.enable_finding_aggregator ? aws_securityhub_finding_aggregator.this[0].id : null
}