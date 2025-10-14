output "project_names" {
  value = [for p in aws_codebuild_project.this : p.name]
}

output "project_arns" {
  value = [for p in aws_codebuild_project.this : p.arn]
}

output "log_group_names" {
  description = "Simple list of CloudWatch Log Group names for CodeBuild projects"
  value       = [for p in aws_codebuild_project.this : "/aws/codebuild/${p.name}"]
}
