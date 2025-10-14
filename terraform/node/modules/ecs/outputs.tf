output "ecs_cluster_id" {
  value       = try(aws_ecs_cluster.this[0].id, null)
  description = "ECSクラスターのID"
}

output "ecs_cluster_name" {
  description = "The name of the ECS cluster."
  value       = try(aws_ecs_cluster.this[0].name, null)
}

# output "ecs_service_name" {
#   value       = aws_ecs_service.this.name
#   description = "ECSサービス名"
# }

output "ecs_task_definition_arn" {
  description = "The ARN of the ECS task definition."
  value       = try(aws_ecs_task_definition.this[0].arn, null)
}

output "ecs_task_definition_family" {
  description = "The family name of the ECS task definition."
  value       = try(aws_ecs_task_definition.this[0].family, null)
}

output "cloudwatch_log_group_name" {
  description = "ECS タスクロググループの名前。"
  value       = aws_cloudwatch_log_group.task_log_group[0].name
}

output "cloudwatch_log_group_arn" {
  description = "ECS タスクロググループの ARN。"
  value       = aws_cloudwatch_log_group.task_log_group[0].arn
}