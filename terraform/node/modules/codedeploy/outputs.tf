output "app_id" {
  value = aws_codedeploy_app.this.id
}

output "app_name" {
  value = aws_codedeploy_app.this.name
}

output "deployment_group_ids" {
  value = { for k, dg in aws_codedeploy_deployment_group.this : k => dg.id }
}

output "deployment_group_names" {
  value = [for dg in aws_codedeploy_deployment_group.this : dg.deployment_group_name]
}
