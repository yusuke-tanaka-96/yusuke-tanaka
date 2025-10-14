output "inspector_enabled_account_ids" {
  description = "Account IDs enabled for Inspector"
  value       = aws_inspector2_enabler.this.account_ids
}