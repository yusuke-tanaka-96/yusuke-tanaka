# This file was automatically generated from main.tf
# Generated on 2025-08-26 09:19:54

module "iam_apigateway_role" {
  source = "../../modules/iam"

  name_prefix = local.name_prefix
  name_suffix = "apigateway"
  merged_tags = merge(local.merged_tags, {
    Owner = "backend"
  })

  role_name        = "${local.name_prefix}-apigateway-role"
  trusted_entities = local.apigateway-role.trusted_entities
  policy_arns      = local.apigateway-role.policy_arns
  inline_policies  = local.apigateway-role.inline_policies
}

module "iam-ecs-api-task-execution-role" {
  source = "../../modules/iam"

  name_prefix = local.name_prefix
  merged_tags = merge(local.merged_tags, {
    Owner = "backend"
  })

  role_name         = "${local.name_prefix}-ecs-api-task-execution-role"
  trusted_entities  = local.ecs-task-execution-role.trusted_entities
  service_condition = local.ecs-task-execution-role.service_condition
  inline_policies   = local.ecs-task-execution-role.inline_policies
}

module "iam-ecs-mgmt-task-execution-role" {
  source = "../../modules/iam"

  name_prefix = local.name_prefix
  merged_tags = merge(local.merged_tags, {
    Owner = "backend"
  })

  role_name         = "${local.name_prefix}-ecs-mgmt-task-execution-role"
  trusted_entities  = local.ecs-task-execution-role.trusted_entities
  service_condition = local.ecs-task-execution-role.service_condition
  inline_policies   = local.ecs-task-execution-role.inline_policies
}


module "iam-ecs-mgmt-task-role" {
  source = "../../modules/iam"

  name_prefix = local.name_prefix
  merged_tags = merge(local.merged_tags, {
    Owner = "backend"
  })

  role_name         = "${local.name_prefix}-ecs-mgmt-task-role"
  trusted_entities  = local.ecs-mgmt-task-role.trusted_entities
  service_condition = local.ecs-mgmt-task-role.service_condition
  inline_policies   = local.ecs-mgmt-task-role.inline_policies
}

module "iam-lambda-auth-tenant-role" {
  source = "../../modules/iam"

  name_prefix = local.name_prefix
  merged_tags = merge(local.merged_tags, {
    Owner = "backend"
  })

  role_name         = "${local.name_prefix}-lambda-auth-tenant-role"
  trusted_entities  = local.lambda-auth-tenant-role.trusted_entities
  service_condition = local.lambda-auth-tenant-role.service_condition
  inline_policies   = local.lambda-auth-tenant-role.inline_policies
}

module "iam-ec2-bastion-instance-role" {
  source = "../../modules/iam"

  name_prefix = local.name_prefix
  merged_tags = merge(local.merged_tags, {
    Owner = "backend"
  })

  create_instance_profile = true
  role_name               = "${local.name_prefix}-ec2-bastion-instance-role"
  trusted_entities        = local.ec2-bastion-instance-role.trusted_entities
  service_condition       = local.ec2-bastion-instance-role.service_condition
  policy_arns             = local.ec2-bastion-instance-role.policy_arns
  inline_policies         = local.ec2-bastion-instance-role.inline_policies
}

module "iam-ec2-node-instance-role" {
  source = "../../modules/iam"

  name_prefix = local.name_prefix
  merged_tags = merge(local.merged_tags, {
    Owner = "backend"
  })

  create_instance_profile = true
  role_name               = "${local.name_prefix}-ec2-node-instance-role"
  trusted_entities        = local.ec2-node-instance-role.trusted_entities
  service_condition       = local.ec2-node-instance-role.service_condition
  policy_arns             = local.ec2-node-instance-role.policy_arns
  inline_policies         = local.ec2-node-instance-role.inline_policies
}

module "iam-codepipeline-service-role" {
  source = "../../modules/iam"

  name_prefix = local.name_prefix
  merged_tags = merge(local.merged_tags, {
    Owner = "backend"
  })

  role_name         = "${local.name_prefix}-codepipeline-service-role"
  trusted_entities  = local.codepipeline-service-role.trusted_entities
  service_condition = local.codepipeline-service-role.service_condition
  inline_policies   = local.codepipeline-service-role.inline_policies
}

module "iam-codebuild-service-role" {
  source = "../../modules/iam"

  name_prefix = local.name_prefix
  merged_tags = merge(local.merged_tags, {
    Owner = "backend"
  })

  role_name         = "${local.name_prefix}-codebuild-service-role"
  trusted_entities  = local.codebuild-service-role.trusted_entities
  service_condition = local.codebuild-service-role.service_condition
  inline_policies   = local.codebuild-service-role.inline_policies
}

module "iam-codedeploy-service-role" {
  source = "../../modules/iam"

  name_prefix = local.name_prefix
  merged_tags = merge(local.merged_tags, {
    Owner = "backend"
  })

  role_name         = "${local.name_prefix}-codedeploy-service-role"
  trusted_entities  = local.codedeploy-service-role.trusted_entities
  service_condition = local.codedeploy-service-role.service_condition
  policy_arns       = local.codedeploy-service-role.policy_arns
  inline_policies   = local.codedeploy-service-role.inline_policies
}

module "iam-lambda-secrets-manager-rotati-role" {
  source = "../../modules/iam"

  name_prefix = local.name_prefix
  role_name   = "${local.name_prefix}-lambda-secrets-manager-rotati-role"
  merged_tags = local.merged_tags

  trusted_entities = local.lambda-secrets-manager-rotati-role.trusted_entities
  inline_policies  = local.lambda-secrets-manager-rotati-role.inline_policies
}

