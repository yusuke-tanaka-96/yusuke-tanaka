output "role_name" {
  description = "The name of the IAM Role"
  value       = aws_iam_role.this.name
}

output "role_arn" {
  description = "The ARN of the IAM Role"
  value       = aws_iam_role.this.arn
}

output "inline_policy_names" {
  description = "Names of the inline policies"
  value       = [for policy in aws_iam_role_policy.inline : policy.name]
}

output "instance_profile_name" {
  description = "The name of the instance profile"
  value       = length(aws_iam_instance_profile.this) > 0 ? aws_iam_instance_profile.this[0].name : null
}


