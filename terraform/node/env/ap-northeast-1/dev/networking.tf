# This file was automatically generated from main.tf
# Generated on 2025-08-26 09:19:54

module "vpc-backend" {
  source = "../../modules/vpc"

  name_prefix = local.name_prefix
  name_suffix = "backend"
  merged_tags = merge(local.merged_tags, {
    Owner = "backend"
  })

  vpc_cidr = "${local.vpc-backend-prefix}.0.0/16"

  public_subnet_cidrs = ["${local.vpc-backend-prefix}.1.0/24"]
  # FIXME: tenantとoperationと２つに分けるべき
  private_subnet_cidrs = ["${local.vpc-backend-prefix}.101.0/24", "${local.vpc-backend-prefix}.102.0/24", "${local.vpc-backend-prefix}.111.0/24", "${local.vpc-backend-prefix}.112.0/24"]
  protect_subnet_cidrs = ["${local.vpc-backend-prefix}.201.0/24", "${local.vpc-backend-prefix}.202.0/24"]

  public_subnet_names = [
    "${local.name_prefix}-subnet-public-backend-1"
  ]
  private_subnet_names = [
    "${local.name_prefix}-subnet-private-backend-tenant-api-1",
    "${local.name_prefix}-subnet-private-backend-tenant-api-2",
    "${local.name_prefix}-subnet-private-backend-internal-api-1",
    "${local.name_prefix}-subnet-private-backend-internal-api-2"
  ]
  protect_subnet_names = [
    "${local.name_prefix}-subnet-private-backend-db-1",
    "${local.name_prefix}-subnet-private-backend-db-2"
  ]

  azs = local.availability_zone

  igw_name               = "${local.name_prefix}-igw-backend"
  nat_gateway_subnet_ids = [module.vpc-backend.public_subnet_ids[0]]

  s3_log_bucket_arn = module.s3-logs-bucket-replication.bucket_arn
  s3_log_prefix     = "${local.merged_tags["Project"]}/${local.merged_tags["Environment"]}/"
  iam_role_arn      = module.iam-flowlogs-cw-role.role_arn

  security_groups = local.backend_security_groups
  sg_db_name      = "${local.name_prefix}-sg-db-backend"

  cloudwatch_logs_endpoint_subnet_ids = [module.vpc-backend.private_subnet_ids[0],
    module.vpc-backend.private_subnet_ids[1],
    module.vpc-backend.private_subnet_ids[2]
  ]

  api_gateway_endpoint_subnet_ids = [
    module.vpc-backend.private_subnet_ids[2],
    module.vpc-backend.private_subnet_ids[3]
  ]

  secretsmanager_endpoint_subnet_ids = [
    module.vpc-backend.private_subnet_ids[2],
    module.vpc-backend.private_subnet_ids[3]
  ]

  vpc_ep_s3_name = "${local.name_prefix}-s3-endpoint-backend"

  nacl_rules              = local.nacl_rules_backend
  ssm_endpoint_subnet_ids = module.vpc-backend.public_subnet_ids
  ssm_endpoint_sg_ids     = [module.vpc-backend.security_group_ids[2]]
}

module "vpc-testnet-pf1" {
  source = "../../modules/vpc"

  name_prefix = local.name_prefix
  name_suffix = "testnet-pf1"
  merged_tags = merge(local.merged_tags, {
    Owner = "testnet-pf1"
  })

  vpc_cidr = "${local.vpc-testnet-pf1-prefix}.0.0/16"

  public_subnet_cidrs  = ["${local.vpc-testnet-pf1-prefix}.11.0/24"]
  private_subnet_cidrs = ["${local.vpc-testnet-pf1-prefix}.111.0/24", "${local.vpc-testnet-pf1-prefix}.112.0/24", "${local.vpc-testnet-pf1-prefix}.113.0/24"]

  public_subnet_names = [
    "${local.name_prefix}-subnet-public-testnet-pf1-1"
  ]
  private_subnet_names = [
    "${local.name_prefix}-subnet-private-testnet-pf1-1",
    "${local.name_prefix}-subnet-private-testnet-pf1-2",
    "${local.name_prefix}-subnet-private-testnet-pf1-3"
  ]

  azs = local.availability_zone

  igw_name               = "${local.name_prefix}-igw-testnet-pf1"
  nat_gateway_subnet_ids = [module.vpc-testnet-pf1.public_subnet_ids[0]]

  s3_log_bucket_arn = module.s3-logs-bucket-replication.bucket_arn
  s3_log_prefix     = "${local.merged_tags["Project"]}/${local.merged_tags["Environment"]}/"
  iam_role_arn      = module.iam-flowlogs-cw-role.role_arn

  peer_vpc_id = module.vpc-backend.vpc_id
  peer_vpc_cidrs = [
    module.vpc-backend.private_subnet_cidrs[0],
    module.vpc-backend.private_subnet_cidrs[1],
    module.vpc-backend.public_subnet_cidrs[0]
  ]
  public_route_table_id  = module.vpc-backend.public_route_table_id
  private_route_table_id = module.vpc-backend.private_route_table_id

  security_groups = local.testnet_pf1_security_groups

  cloudwatch_logs_endpoint_subnet_ids = module.vpc-testnet-pf1.private_subnet_ids
  vpc_ep_s3_name                      = "${local.name_prefix}-s3-endpoint-testnet-pf1"

  nacl_rules              = local.nacl_rules_testnet_pf1
  ssm_endpoint_subnet_ids = module.vpc-testnet-pf1.private_subnet_ids
  ssm_endpoint_sg_ids     = [module.vpc-testnet-pf1.security_group_ids[2]]

  secretsmanager_endpoint_subnet_ids = module.vpc-testnet-pf1.private_subnet_ids
}

module "vpc-testnet-pf2" {
  source = "../../modules/vpc"

  name_prefix = local.name_prefix
  name_suffix = "testnet-pf2"
  merged_tags = merge(local.merged_tags, {
    Owner = "testnet-pf2"
  })

  vpc_cidr = "${local.vpc-testnet-pf2-prefix}.0.0/16"

  public_subnet_cidrs  = ["${local.vpc-testnet-pf2-prefix}.11.0/24"]
  private_subnet_cidrs = ["${local.vpc-testnet-pf2-prefix}.111.0/24", "${local.vpc-testnet-pf2-prefix}.112.0/24", "${local.vpc-testnet-pf2-prefix}.113.0/24"]

  public_subnet_names = [
    "${local.name_prefix}-subnet-public-testnet-pf2-1"
  ]
  private_subnet_names = [
    "${local.name_prefix}-subnet-private-testnet-pf2-1",
    "${local.name_prefix}-subnet-private-testnet-pf2-2",
    "${local.name_prefix}-subnet-private-testnet-pf2-3"
  ]

  azs = local.availability_zone

  igw_name               = "${local.name_prefix}-igw-testnet-pf2"
  nat_gateway_subnet_ids = [module.vpc-testnet-pf2.public_subnet_ids[0]]

  s3_log_bucket_arn = module.s3-logs-bucket-replication.bucket_arn
  s3_log_prefix     = "${local.merged_tags["Project"]}/${local.merged_tags["Environment"]}/"
  iam_role_arn      = module.iam-flowlogs-cw-role.role_arn

  peer_vpc_id = module.vpc-backend.vpc_id
  peer_vpc_cidrs = [
    module.vpc-backend.private_subnet_cidrs[0],
    module.vpc-backend.private_subnet_cidrs[1],
    module.vpc-backend.public_subnet_cidrs[0]
  ]
  public_route_table_id  = module.vpc-backend.public_route_table_id
  private_route_table_id = module.vpc-backend.private_route_table_id

  security_groups = local.testnet_pf2_security_groups

  cloudwatch_logs_endpoint_subnet_ids = module.vpc-testnet-pf2.private_subnet_ids
  vpc_ep_s3_name                      = "${local.name_prefix}-s3-endpoint-testnet-pf2"

  nacl_rules              = local.nacl_rules_testnet_pf2
  ssm_endpoint_subnet_ids = module.vpc-testnet-pf2.private_subnet_ids
  ssm_endpoint_sg_ids     = [module.vpc-testnet-pf2.security_group_ids[2]]

  secretsmanager_endpoint_subnet_ids = module.vpc-testnet-pf2.private_subnet_ids
}
