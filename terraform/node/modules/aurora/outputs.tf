# Aurora Cluster の ID
output "cluster_id" {
  description = "ID of the Aurora RDS Cluster"
  value       = aws_rds_cluster.this.id
}

# Aurora Cluster のエンドポイント（読み書き）
output "endpoint" {
  description = "Writer endpoint of the Aurora RDS Cluster"
  value       = aws_rds_cluster.this.endpoint
}

# Aurora Cluster のリーダーエンドポイント（読み取り専用）
output "reader_endpoint" {
  description = "Reader endpoint of the Aurora RDS Cluster"
  value       = aws_rds_cluster.this.reader_endpoint
}

# クラスタインスタンスの identifier
output "instance_id" {
  description = "Identifier of the Aurora Cluster Instance"
  value       = aws_rds_cluster_instance.this.id
}

# クラスタインスタンスの ARN
output "instance_arn" {
  description = "ARN of the Aurora Cluster Instance"
  value       = aws_rds_cluster_instance.this.arn
}

output "cluster_identifier" {
  description = "cluster_identifier of the Aurora Cluster"
  value       = aws_rds_cluster_instance.this.cluster_identifier
}

output "database_name" {
  description = "cluster_identifier of the Aurora Cluster"
  value       = var.database_name
}

output "rds_secret_arn" {
  description = "ARN of the RDS master user secret"
  value       = aws_rds_cluster.this.master_user_secret[0].secret_arn
}

output "cluster_arn" {
  description = "ARN of the Aurora RDS Cluster"
  value       = aws_rds_cluster.this.arn
}