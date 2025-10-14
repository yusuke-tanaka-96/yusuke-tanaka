data "aws_region" "current" {}
data "aws_caller_identity" "current" {}
data "aws_availability_zones" "az" {}
data "aws_kms_key" "key" {
  key_id = "alias/key"
} // TODO: Terraform管理に移行する

data "aws_s3_bucket" "ext_node_health" {
  bucket = "${local.environment}-node-monitoring-bucket"
} // TODO: Terraform管理に移行する

data "aws_s3_bucket" "node_deploy_code" {
  bucket = "${local.environment}-node-monitoring-bucket"
}

data "aws_ami" "amazon_linux_2023" {
  most_recent = true # 最も新しいAMIを取得
  owners      = ["amazon"]

  # フィルター条件
  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "state"
    values = ["available"]
  }
}

data "aws_ami" "ubuntu_ami" {
  most_recent = true # 最も新しいAMIを取得
  # Ubuntu の公式オーナーID (Canonical)
  owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-*-amd64-server-*"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "state"
    values = ["available"]
  }
}

data "aws_ami_ids" "custom_amis" {
  owners = [local.aws_account]

  filter {
    name   = "name"
    values = ["ubuntu-custom-*"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

data "aws_ami" "custom_ami" {
  for_each = toset(data.aws_ami_ids.custom_amis.ids)

  filter {
    name   = "image-id"
    values = [each.value]
  }
}

data "aws_api_gateway_rest_api" "internal-api" {
  name = "${local.name_prefix}-backend-internal-api"
}

data "aws_api_gateway_rest_api" "tenant-api" {
  name = "${local.name_prefix}-backend-tenant-api"
}

data "aws_ssm_parameters_by_path" "env_test1_internal_api" {
  path            = "/test1/internal/api/"
  recursive       = true
  with_decryption = true
}

data "aws_ssm_parameters_by_path" "env_test1_tenant_api" {
  path            = "/test1/tenant/api/"
  recursive       = true
  with_decryption = true
}

data "aws_ssm_parameters_by_path" "env_test1_lambda_authorizer" {
  path            = "/test1/lambda/authorizer/"
  recursive       = true
  with_decryption = true
}

data "aws_ssm_parameters_by_path" "env_test1_test_scripts" {
  path            = "/test1/test/scripts/"
  recursive       = true
  with_decryption = true
}

data "aws_secretsmanager_secret" "rds" {
  arn = module.aurora.rds_secret_arn
}

data "aws_secretsmanager_secret_version" "rds" {
  secret_id = data.aws_secretsmanager_secret.rds.id
}

data "aws_ssm_parameter" "private-ca-arn" {
  name            = "/acmpca/private-ca-arn"
  with_decryption = true
}
