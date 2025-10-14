module "cwlogs_node_system" {
  source         = "../../modules/cloudwatch"
  log_group_name = "/${local.name_prefix}/node-system-log"
  kms_key_arn    = local.kms_key_arn
  name_prefix    = local.name_prefix
  name_suffix    = "backend"
  merged_tags = merge(local.merged_tags, {
    Owner = "backend"
  })
}

module "cw-logs-backend-tenant-api" {
  source = "../../modules/cloudwatch"

  log_group_name = "/aws/apigateway/${local.name_prefix}-backend-tenant-api"
  kms_key_arn    = local.kms_key_arn
  name_prefix    = local.name_prefix
  name_suffix    = "apigateway"
  merged_tags = merge(local.merged_tags, {
    Owner = "api gateway"
  })
}

module "cwlogs-lambda-auth-tenant" {
  source = "../../modules/cloudwatch"

  log_group_name = "/aws/lambda/${local.name_prefix}-backend-tenant"
  kms_key_arn    = local.kms_key_arn
  merged_tags = merge(local.merged_tags, {
    Owner = "backend"
  })
}

module "cwlogs-ec2-node-instance-pf1" {
  source = "../../modules/cloudwatch"

  log_group_name = "/aws/ec2/${local.name_prefix}-asg-testnet-pf1"
  kms_key_arn    = local.kms_key_arn
  merged_tags = merge(local.merged_tags, {
    Owner = "node"
  })
}

module "cwlogs-ec2-node-instance-pf2" {
  source = "../../modules/cloudwatch"

  log_group_name = "/aws/ec2/${local.name_prefix}-asg-testnet-pf2"
  kms_key_arn    = local.kms_key_arn
  merged_tags = merge(local.merged_tags, {
    Owner = "node"
  })
}

module "cwlogs-ec2-node-instance-pf1-nginx-access" {
  source = "../../modules/cloudwatch"

  log_group_name = "/aws/ec2/${local.name_prefix}-asg-testnet-pf1-nginx-access-log"
  kms_key_arn    = local.kms_key_arn
  merged_tags = merge(local.merged_tags, {
    Owner = "node"
  })
}

module "cwlogs-ec2-node-instance-pf2-nginx-access" {
  source = "../../modules/cloudwatch"

  log_group_name = "/aws/ec2/${local.name_prefix}-asg-testnet-pf2-nginx-access-log"
  kms_key_arn    = local.kms_key_arn
  merged_tags = merge(local.merged_tags, {
    Owner = "node"
  })
}

module "cwlogs_ecs_backend_tenant" {
  source = "../../modules/cloudwatch"

  log_group_name = "/aws/ecs/${local.name_prefix}-service-event-tenant"
  kms_key_arn    = local.kms_key_arn
  name_prefix    = local.name_prefix
  name_suffix    = "ecs-backend-tenant-api"
  merged_tags = merge(local.merged_tags, {
    Owner = "backend"
  })
}

module "cwlogs_ec2_bastion_log_group" {
  source = "../../modules/cloudwatch"
  for_each = toset([
    "/aws/ec2/${local.name_prefix}-backend-bastion-messages-log",
    "/aws/ec2/${local.name_prefix}-backend-bastion-secure-log",
    "/aws/ec2/${local.name_prefix}-backend-bastion-yum-log",
    "/aws/ec2/${local.name_prefix}-backend-bastion-newrelic-log",
    "/aws/ec2/${local.name_prefix}-backend-bastion-ssm-agent-log",
    "/aws/ec2/${local.name_prefix}-backend-bastion-cloud-init-log",
    "/aws/ec2/${local.name_prefix}-backend-bastion-sysdig-log"
  ])
  log_group_name = each.key
  kms_key_arn    = local.kms_key_arn
  merged_tags = merge(local.merged_tags, {
    Owner = "backend"
  })
}

module "cwlogs_lambda_secrets_manager_rotation" {
  source = "../../modules/cloudwatch"

  log_group_name = "/aws/lambda/${local.name_prefix}-lambda-secrets-manager-rotation"
  kms_key_arn    = local.kms_key_arn
  name_prefix    = local.name_prefix
  name_suffix    = "lambda-secrets-manager-rotation"
  merged_tags = merge(local.merged_tags, {
    Owner = "backend"
  })
}

