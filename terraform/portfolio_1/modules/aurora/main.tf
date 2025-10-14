# DB Subnet Group
resource "aws_db_subnet_group" "this" {
  name       = "${var.name_prefix}-aurora-subnet-${var.name_suffix}"
  subnet_ids = var.subnet_ids
  tags       = var.merged_tags
}

# Aurora RDS Cluster
resource "aws_rds_cluster" "this" {
  cluster_identifier              = var.cluster_identifier
  engine                          = "aurora-postgresql"
  storage_type                    = "aurora-iopt1"
  engine_version                  = var.engine_version
  database_name                   = var.database_name
  master_username                 = var.master_username
  manage_master_user_password     = var.manage_master_user_password
  db_subnet_group_name            = aws_db_subnet_group.this.name
  vpc_security_group_ids          = var.security_group_ids
  backup_retention_period         = var.backup_retention_period
  skip_final_snapshot             = var.skip_final_snapshot
  storage_encrypted               = true
  enabled_cloudwatch_logs_exports = ["iam-db-auth-error", "postgresql", "instance"]
  tags                            = var.merged_tags
}

# Aurora RDS Cluster Instance
resource "aws_rds_cluster_instance" "this" {
  identifier          = "${var.name_prefix}-aurora-${var.name_suffix}-1"
  cluster_identifier  = aws_rds_cluster.this.id
  instance_class      = var.instance_class
  engine              = "aurora-postgresql"
  publicly_accessible = var.publicly_accessible
  tags                = var.merged_tags
}

resource "aws_rds_cluster_instance" "reader" {
  count               = var.reader_count
  identifier          = "${var.name_prefix}-aurora-${var.name_suffix}-reader-${count.index}"
  cluster_identifier  = aws_rds_cluster.this.id
  instance_class      = var.instance_class
  engine              = "aurora-postgresql"
  publicly_accessible = var.publicly_accessible
  tags                = var.merged_tags
}
