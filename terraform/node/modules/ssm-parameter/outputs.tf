# ------------------------------------------------------------
# 出力値
# ------------------------------------------------------------
output "name" {
  description = "The name of the parameter."
  value       = [for parameter in aws_ssm_parameter.this : parameter.name]
}

output "arn" {
  description = "The ARN of the parameter."
  value       = [for parameter in aws_ssm_parameter.this : parameter.arn]
}

output "version" {
  description = "The version of the parameter."
  value       = [for parameter in aws_ssm_parameter.this : parameter.version]
}
