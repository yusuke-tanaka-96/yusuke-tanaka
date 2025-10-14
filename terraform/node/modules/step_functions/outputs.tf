output "state_machine_arn" {
  value = aws_sfn_state_machine.this.arn
}

output "state_machine_name" {
  value = aws_sfn_state_machine.this.name
}

output "log_group_name" {
  value = var.enable_logging ? aws_cloudwatch_log_group.sfn_logs[0].name : null
}

output "log_group_arn" {
  value = var.enable_logging ? aws_cloudwatch_log_group.sfn_logs[0].arn : null
}
