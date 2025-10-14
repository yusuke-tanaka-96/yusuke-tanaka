#########################################
#EC2
#########################################

module "ec2_bastion" {
  source = "../../modules/ec2"

  name_prefix = local.name_prefix
  name_suffix = "backend"
  merged_tags = merge(local.merged_tags, {
    Owner = "backend"
  })

  instance_name               = "${local.name_prefix}-ec2-bastion"
  ami_id                      = local.ami_id_al
  instance_type               = "t3.medium"
  ec2_subnet_id               = module.vpc-backend.private_subnet_ids[2]
  associate_public_ip_address = false
  security_group_ids_ec2      = [module.vpc-backend.security_group_ids[6]]
  root_volume_size            = 10
  key_pair_name               = local.key_pair_name
  iam_instance_profile        = module.iam-ec2-bastion-instance-role.instance_profile_name
  user_data                   = file("${path.module}/userdata_backend.sh")

  vpc_id = module.vpc-backend.vpc_id
}

module "ec2_testnet_pf1" {
  source = "../../modules/ec2"

  name_prefix = local.name_prefix
  name_suffix = "testnet-pf1"
  merged_tags = merge(local.merged_tags, {
    Owner = "testnet-pf1"
  })

  ami_id                      = local.use_custom_ami && local.selected_custom_ami_id != null ? local.selected_custom_ami_id : data.aws_ami.ubuntu_ami.id
  instance_type               = "r7a.medium"
  ec2_subnet_id               = module.vpc-testnet-pf1.private_subnet_ids[0]
  asg_subnet_ids              = module.vpc-testnet-pf1.private_subnet_ids
  associate_public_ip_address = false
  security_group_ids_ec2      = [module.vpc-testnet-pf1.security_group_ids[1]]
  root_volume_size            = 30
  additional_volume_size      = 2000
  key_pair_name               = local.key_pair_name
  iam_instance_profile        = module.iam-ec2-node-instance-role.instance_profile_name
  user_data                   = file("${path.module}/userdata_pf1_testnet.sh")

  asg_name          = "${local.name_prefix}-asg-testnet-pf1"
  lt_name           = "${local.name_prefix}-lt-testnet-pf1"
  lb_name           = "${local.name_prefix}-lb-testnet-pf1"
  lb_tg_name        = "${local.name_prefix}-tg-tnet-pf1"
  log_group_name    = "/aws/ec2/${local.name_prefix}-asg-testnet-pf1"
  health_check_path = "/health"

  lb_access_logs = {
    bucket = module.s3-cloudwatch-logs-backup.bucket_name
    prefix = "S3/nlb/pf1"
  }

  security_group_ids_lb = [module.vpc-testnet-pf1.security_group_ids[0]]
  alb_subnet_ids        = module.vpc-testnet-pf1.private_subnet_ids
  vpc_id                = module.vpc-testnet-pf1.vpc_id
  load_balancer_type    = "network"
  protocol              = "TLS"
  ssl_policy            = "ELBSecurityPolicy-TLS13-1-2-Res-2021-06"
  certificate_arn       = module.private-ac.certificate_arn
  main_listener_port    = "443"
  target_protocol       = "TCP"

  # Auto Scaling 用
  min_size                              = 2
  max_size                              = 4
  desired_capacity                      = 2
  active_capacity_factor                = 2
  refresh_buffer_factor                 = 2
  warm_pool_min_size                    = 1
  warm_pool_max_group_prepared_capacity = 3

  # Lifecycle Hook 用
  lifecycle_hook_heartbeat_timeout = 7200

  # Instance Maintenance Policy
  min_healthy_percentage = 100
  max_healthy_percentage = 200
}

module "ec2_testnet_pf2" {
  source = "../../modules/ec2"

  name_prefix = local.name_prefix
  name_suffix = "testnet-pf2"
  merged_tags = merge(local.merged_tags, {
    Owner = "testnet-pf2"
  })

  ami_id                      = local.use_custom_ami && local.selected_custom_ami_id != null ? local.selected_custom_ami_id : data.aws_ami.ubuntu_ami.id
  instance_type               = "r6a.xlarge"
  ec2_subnet_id               = module.vpc-testnet-pf2.private_subnet_ids[0]
  asg_subnet_ids              = module.vpc-testnet-pf2.private_subnet_ids
  associate_public_ip_address = false
  security_group_ids_ec2      = [module.vpc-testnet-pf2.security_group_ids[1]]
  root_volume_size            = 30
  additional_volume_size      = 2000
  key_pair_name               = local.key_pair_name
  iam_instance_profile        = module.iam-ec2-node-instance-role.instance_profile_name
  user_data                   = file("${path.module}/userdata_pf2_sepolia.sh")

  asg_name          = "${local.name_prefix}-asg-testnet-pf2"
  lt_name           = "${local.name_prefix}-lt-testnet-pf2"
  lb_name           = "${local.name_prefix}-lb-testnet-pf2"
  lb_tg_name        = "${local.name_prefix}-tg-tnet-pf2"
  log_group_name    = "/aws/ec2/${local.name_prefix}-asg-testnet-pf2"
  health_check_path = "/health"

  lb_access_logs = {
    bucket = module.s3-cloudwatch-logs-backup.bucket_name
    prefix = "S3/nlb/pf2"
  }

  security_group_ids_lb = [module.vpc-testnet-pf2.security_group_ids[0]]
  alb_subnet_ids        = module.vpc-testnet-pf2.private_subnet_ids
  vpc_id                = module.vpc-testnet-pf2.vpc_id
  load_balancer_type    = "network"
  protocol              = "TLS"
  ssl_policy            = "ELBSecurityPolicy-TLS13-1-2-Res-2021-06"
  certificate_arn       = module.private-ac.certificate_arn
  main_listener_port    = "443"
  target_protocol       = "TCP"

  # Auto Scaling 用
  min_size                              = 2
  max_size                              = 4
  desired_capacity                      = 2
  active_capacity_factor                = 2
  refresh_buffer_factor                 = 2
  warm_pool_min_size                    = 1
  warm_pool_max_group_prepared_capacity = 3

  # Lifecycle Hook 用
  lifecycle_hook_heartbeat_timeout = 7200

  # Instance Maintenance Policy
  min_healthy_percentage = 100
  max_healthy_percentage = 200
}

#########################################
#ecr
#########################################
module "ecr_repositories" {
  source       = "../../modules/ecr"
  repositories = local.ecr_repositories
}

locals {
  ecr_repositories = [
    {
      name                 = "${local.name_prefix}-ecr-tenant-api"
      image_tag_mutability = "MUTABLE"
      encryption_type      = "KMS"
      kms_key              = "arn:aws:kms:ap-northeast-1:382828593760:key/c2bf1bf7-1fd8-451c-9dc5-3a7ca90919df"
      scan_on_push         = false
      tags                 = {}
    }
  ]
}

#########################################
#ecs
#########################################
module "ecs_backend_tenant_api" {
  source = "../../modules/ecs"

  name_prefix = local.name_prefix
  name_suffix = "backend-tenant-api"
  merged_tags = merge(local.merged_tags, {
    Owner = "backend"
  })

  cluster_name             = "${local.name_prefix}-ecs-backend-tenant-api-cluster"
  task_definition_family   = "${local.name_prefix}-ecs-backend-tenant-api-task"
  execution_role_arn       = module.iam-ecs-api-task-execution-role.role_arn
  task_role_arn            = module.iam-ecs-api-task-role.role_arn
  container_name           = "tenant-api"
  container_image          = "${local.aws_account}.dkr.ecr.${local.region}.amazonaws.com/${local.name_prefix}-ecr-tenant-api:latest"
  ecs_service_name         = "service-tenant-api"
  service_subnets          = [module.vpc-backend.private_subnet_ids[0], module.vpc-backend.private_subnet_ids[1]]
  service_security_groups  = [module.vpc-backend.security_group_ids[1]]
  lb_target_group_arn      = module.elb-backend-tenant-api.lb_target_group_arn_blue
  kms_key_id               = local.kms_key_arn
  secret_variables         = local.env_test1_tenant_api
  container_port           = "8080"
  autoscaling_max_capacity = 5
  autoscaling_min_capacity = 2
  service_desired_count    = 2
  container_entrypoint     = local.cf_entrypoint
  container_command        = local.cf_command

  # === Blue/Green デプロイメント設定 ===
  enable_blue_green_deployment = true                                        # Blue/Greenを有効にする
  codedeploy_service_role_arn  = module.iam-codedeploy-service-role.role_arn # 作成したCodeDeployロールのARN
  lb_target_group_name_blue    = module.elb-backend-tenant-api.lb_target_group_name_blue
  lb_target_group_name_green   = module.elb-backend-tenant-api.lb_target_group_name_green
  main_lb_listener_arn         = module.elb-backend-tenant-api.lb_listener_main_arn
  test_lb_listener_arn         = module.elb-backend-tenant-api.lb_listener_test_arn

  # sysdig 用
  sysdig_ecr_repository_url = "${local.aws_account}.dkr.ecr.${local.region}.amazonaws.com/${local.name_prefix}-sysdig-workload-agent"
  sysdig_image_tag          = "5.5.0"
  sysdig_api_key_secret_arn = "arn:aws:secretsmanager:${local.region}:${local.aws_account}:secret:sysdig-api-key-MEwkr9"
  task_cpu                  = "2048" # >= api(512)  + sysdig(512)  + newrelic(256)
  task_memory               = "4096" # >= api(1024) + sysdig(1024) + newrelic(512)

  # new relic
  newrelic_ecr_repository_url = module.ecr-newrelic.repository_urls[0]
  newrelic_image_tag          = "1.12.20"
  newrelic_api_key_secret_arn = data.aws_secretsmanager_secret_version.newrelic_apikey_for_ecs.secret_id
}

#########################################
#lb for ecs
#########################################
module "elb_backend_tenant_api" {
  source = "../../modules/ec2"

  name_prefix = local.name_prefix
  name_suffix = "backend-tenant-api"
  merged_tags = merge(local.merged_tags, {
    Owner = "backend"
  })

  lb_name               = "${local.name_prefix}-lb-be-ten-api"
  lb_tg_name            = "${local.name_prefix}-tg-be-ten-api"
  target_type           = "ip"
  load_balancer_type    = "network"
  protocol              = "TLS"
  ssl_policy            = "ELBSecurityPolicy-TLS13-1-2-Res-2021-06"
  certificate_arn       = module.acm-test1.certificate_arn
  main_listener_port    = "443"
  security_group_ids_lb = [module.vpc-backend.security_group_ids[0]]
  alb_subnet_ids        = [module.vpc-backend.private_subnet_ids[0], module.vpc-backend.private_subnet_ids[1]]
  vpc_id                = module.vpc-backend.vpc_id
  enable_test_listener  = true
  health_check_path     = "/api/v1/health"
  target_port           = "80"
  target_protocol       = "TCP"

  lb_access_logs = {
    bucket = module.s3-cloudwatch-logs-backup.bucket_name
    prefix = "S3/nlb/tenant"
  }
}

#########################################
#lambda
#########################################
module "lambda_auth_tenant" {
  source = "../../modules/lambda"

  function_name         = "${local.name_prefix}-backend-lambda-tenant"
  iam_role_arn          = module.iam-lambda-auth-tenant-role.role_arn
  handler               = "index.handler"
  runtime               = "nodejs20.x"
  package_type          = "Zip"
  local_zip_path        = "../../lambda/lambda_Authorizer/dummy.zip"
  environment_variables = local.env_test1_lambda_authorizer_tenant
  timeout               = 5
  memory_size           = 128
  subnet_ids = [
    module.vpc-backend.private_subnet_ids[0],
    module.vpc-backend.private_subnet_ids[1]
  ]
  security_group_ids = ["sg-07e9cbbb8b1fb447c", "sg-038663388dcdd363d", module.vpc-backend.security_group_ids[8]]
  log_group          = module.cwlogs-lambda-auth-tenant.log_group_name
}

module "lambda_secrets_manager_rotation" {
  source = "../../modules/lambda"

  function_name  = "${local.name_prefix}-lambda-secrets-manager-rotation"
  iam_role_arn   = module.iam-lambda-secrets-manager-rotati-role.role_arn
  handler        = "lambda_function.lambda_handler"
  runtime        = "python3.13"
  package_type   = "Zip"
  local_zip_path = "../../lambda/secrets-manager-rotation/lambda.zip"
  layer_arns     = [data.aws_lambda_layer_version.secrets_extension.arn]
  timeout        = 180
  environment_variables = [
    {
      name  = "SECRETS_MANAGER_ENDPOINT"
      value = "https://secretsmanager.ap-northeast-1.amazonaws.com"
    }
  ]
  subnet_ids = [
    module.vpc-backend.private_subnet_ids[2],
    module.vpc-backend.private_subnet_ids[3]
  ]
  security_group_ids = [module.vpc-backend.security_group_ids[8]]
  log_group          = module.cwlogs_lambda_secrets_manager_rotation.log_group_name
  invoke_permissions = [
    {
      statement_id = "AllowSecretsManagerService"
      principal    = "secretsmanager.amazonaws.com"
      action       = "lambda:InvokeFunction"
    }
  ]

  merged_tags = merge(local.merged_tags, {
    Owner = "backend"
  })
}
