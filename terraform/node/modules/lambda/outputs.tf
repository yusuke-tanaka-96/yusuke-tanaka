output "lambda_function_name" {
  description = "The name of the Lambda function"
  value       = var.enabled ? aws_lambda_function.this[0].function_name : null
}

output "lambda_function_arn" {
  description = "The ARN of the Lambda function"
  value       = var.enabled ? aws_lambda_function.this[0].arn : null
}

output "lambda_function_invoke_arn" {
  description = "The Invoke ARN of the Lambda function"
  value       = var.enabled ? aws_lambda_function.this[0].invoke_arn : null
}

output "lambda_function_version" {
  description = "The latest published version of the Lambda function"
  value       = var.enabled ? aws_lambda_function.this[0].version : null
}
