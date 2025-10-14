output "repository_urls" {
  description = "ECR repository URLs"
  value       = [for url in aws_ecr_repository.this : url.repository_url]
}

output "repository_arns" {
  description = "ECR repository ARNs"
  value = {
    for k, repo in aws_ecr_repository.this : k => repo.arn
  }
}
