output "pipeline_names" {
  value = [for p in aws_codepipeline.this : p.name]
}

output "pipeline_arns" {
  value = [for p in aws_codepipeline.this : p.arn]
}
