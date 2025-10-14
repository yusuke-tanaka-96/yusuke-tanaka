locals {

  region                  = data.aws_region.current.name
  aws_account             = data.aws_caller_identity.current.account_id
  kms_key_id              = data.aws_kms_key.key.arn
  availability_zone       = data.aws_availability_zones.az.names
  kms_key_arn        = data.aws_kms_key.key.arn
  s3_ext_node_health_arn  = data.aws_s3_bucket.ext_node_health.arn
  s3_node_deploy_code_arn = data.aws_s3_bucket.node_deploy_code.arn

  proj               = "portfolio"
  env                = "dev"
  name_prefix        = "${local.proj}-${local.env}"
  ami_id_al          = "ami-0c2da9ee6644f16e5"
  ami_id_ub          = "ami-026c39f4021df9abe"
  key_pair_name      = "dev-ec2-key"
  environment        = "dev" //TODO: こっちは消す
  lb_tenant_url      = "tenant-api.internal.test1.tnode.io"
  lb_internal_url    = "internal-api.internal.test1.tnode.io"
  lb_sepolia_pf2_url = "sepolia-pf2.internal.test1.tnode.io"
  lb_testnet_pf1_url = "testnet-pf1.internal.test1.tnode.io"
  merged_tags = {
    "Environment" = local.env
    "Project"     = local.proj
    "Owner"       = ""
  }

  rds_secret_arn_base = data.aws_secretsmanager_secret.rds.arn
  env_developinternal_api = concat([
    for names, arn in zipmap(
      data.aws_ssm_parameters_by_path.env_developinternal_api.names,
      data.aws_ssm_parameters_by_path.env_developinternal_api.arns) : {
      name      = element(split("/", names), length(split("/", names)) - 1)
      valueFrom = names
    }
    ],
    [
      {
        name      = "POSTGRES_USERNAME"
        valueFrom = "${module.secrets-manager-rds-cluster.secret_arn}:username::"
      },
      {
        name      = "POSTGRES_PASSWORD"
        valueFrom = "${module.secrets-manager-rds-cluster.secret_arn}:password::"
      }
  ])
  env_developtenant_api = concat([
    for names, arn in zipmap(
      data.aws_ssm_parameters_by_path.env_developtenant_api.names,
      data.aws_ssm_parameters_by_path.env_developtenant_api.arns) : {
      name      = element(split("/", names), length(split("/", names)) - 1)
      valueFrom = names
    }],
    [
      {
        name      = "PRIVATE_CA_BUNDLE"
        valueFrom = "/acmpca/private-ca-bundle"
      }
  ])
  env_developlambda_authorizer_tenant = [
    {
      name  = "POSTGRES_USER"
      value = "${module.secrets-manager-rds-cluster.secret_arn}:username::"
    },
    {
      name  = "POSTGRES_PASSWORD"
      value = "${module.secrets-manager-rds-cluster.secret_arn}:password::"
    },
    {
      name  = "POSTGRES_SECRET_ARN"
      value = module.secrets-manager-rds-cluster.secret_name
    },
    {
      name  = "POSTGRES_DATABASE"
      value = module.aurora.database_name
    },
    {
      name  = "POSTGRES_HOST"
      value = module.aurora.reader_endpoint
    },
    {
      name  = "POSTGRES_PORT"
      value = "5432"
    },
    {
      name  = "USE_MOCK"
      value = "false"
    }
  ]
  env_developlambda_authorizer_internal = [
    {
      name  = "POSTGRES_USER"
      value = "${module.secrets-manager-rds-cluster.secret_arn}:username::"
    },
    {
      name  = "POSTGRES_PASSWORD"
      value = "${module.secrets-manager-rds-cluster.secret_arn}:password::"
    },
    {
      name  = "POSTGRES_SECRET_ARN"
      value = module.secrets-manager-rds-cluster.secret_name
    },
    {
      name  = "POSTGRES_DATABASE"
      value = module.aurora.database_name
    },
    {
      name  = "POSTGRES_HOST"
      value = module.aurora.reader_endpoint
    },
    {
      name  = "POSTGRES_PORT"
      value = "5432"
    }
  ]
  env_developtest_scripts = concat([
    for names, arn in zipmap(
      data.aws_ssm_parameters_by_path.env_developtest_scripts.names,
      data.aws_ssm_parameters_by_path.env_developtest_scripts.arns) : {
      name      = element(split("/", names), length(split("/", names)) - 1)
      valueFrom = names
    }],
    [
      {
        name      = "POSTGRES_USERNAME"
        valueFrom = "${local.rds_secret_arn_base}:username::"
      },
      {
        name      = "POSTGRES_PASSWORD"
        valueFrom = "${local.rds_secret_arn_base}:password::"
      }
  ])
  env_developinternal_api_environment = [
    {
      name  = "AWS_ACCESS_KEY_ID"
      value = ""
    },
    {
      name  = "AWS_SECRET_ACCESS_KEY"
      value = ""
    },
    {
      name  = "POSTGRES_SECRET_ARN"
      value = module.secrets-manager-rds-cluster.secret_arn
    }
  ]
  # バッチ用シークレット
  env_developbatch = [
    {
      name      = "POSTGRES_USERNAME"
      valueFrom = "${module.secrets-manager-rds-cluster.secret_arn}:username::"
    },
    {
      name      = "POSTGRES_PASSWORD"
      valueFrom = "${module.secrets-manager-rds-cluster.secret_arn}:password::"
    }
  ]
  # バッチ用環境変数
  env_developbatch_environment = [
    { name = "AWS_REGION", value = local.region },
    { name = "AWS_SHOULD_LOAD_DEFAULT_CONFIG", value = "true" },
    # { name = "BASE_URL", value = "https://temp.io" },
    { name = "BASE_URL", value = "https://${data.aws_api_gateway_rest_api.internal-api.id}.execute-api.${local.region}.amazonaws.com/${local.environment}" },
    { name = "API_VERSION_PREFIX", value = "/v1" },
    { name = "POSTGRES_HOST", value = module.aurora.endpoint },
    { name = "POSTGRES_PORT", value = "5432" },
    { name = "POSTGRES_DATABASE", value = module.aurora.database_name },
    { name = "POSTGRES_DEBUG", value = "false" },
    { name = "POSTGRES_CONN_MAX_LIFETIME", value = "300s" },
    { name = "POSTGRES_MAX_OPEN_CONNS", value = "80" },
    { name = "POSTGRES_MAX_IDLE_CONNS", value = "10" },
    { name = "AWS_GATEWAY_API_STAGE_API_ID", value = aws_api_gateway_rest_api.test1-backend-internal-api.id },
    { name = "AWS_GATEWAY_API_STAGE_STAGE", value = "test1" },
    { name = "SYSDIG_SIDECAR", value = "auto" },
    { name = "SYSDIG_PRIORITY", value = "availability" }
  ]
  env_developtest_scripts_environment = [
    {
      name  = "GITHUB_TOKEN"
      value = ""
    }
  ]

  vpc-backend-prefix     = "10.5"
  vpc-testnet-pf1-prefix = "10.106"
  vpc-testnet-pf2-prefix = "10.107"





  enable_custom_ami      = local.environment == "dev"
  use_custom_ami         = true
  custom_ami_cutoff_date = "2025-09-01T23:59:59Z"
  custom_ami_candidates = [
    for img in values(data.aws_ami.custom_ami) :
    "${formatdate("YYYYMMDDhhmmss", img.creation_date)}|${img.id}"
    if tonumber(formatdate("YYYYMMDDhhmmss", img.creation_date))
    <= tonumber(formatdate("YYYYMMDDhhmmss", local.custom_ami_cutoff_date))
  ]
  selected_custom_ami_id = length(local.custom_ami_candidates) > 0 ? split("|", sort(local.custom_ami_candidates)[length(local.custom_ami_candidates) - 1])[1] : null
}
# containerDefinitions, command and entryPoint
locals {
  cf_entrypoint = ["sh", "-lc"]
  cf_command    = ["mkdir -p /usr/local/share/ca-certificates && echo \"$PRIVATE_CA_BUNDLE\" > /usr/local/share/ca-certificates/private-ca.crt && (apk add --no-cache ca-certificates >/dev/null 2>&1 || true) && (update-ca-certificates || true) && exec ./api server"]
}
