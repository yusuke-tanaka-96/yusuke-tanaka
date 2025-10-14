module "aurora" {
  source = "../../modules/aurora"

  name_prefix = local.name_prefix
  name_suffix = "backend"
  merged_tags = merge(local.merged_tags, {
    Owner = "backend"
  })

  cluster_identifier          = "${local.name_prefix}-aurora-cluster-backend"
  database_name               = "dev_initdb"
  master_username             = "dev_admin"
  manage_master_user_password = true

  engine_version          = "15.10"
  backup_retention_period = 7
  skip_final_snapshot     = true
  publicly_accessible     = false

  subnet_ids         = module.vpc-backend.protect_subnet_ids
  security_group_ids = [module.vpc-backend.db_sg_id]

  instance_class = "db.t4g.medium"
}
