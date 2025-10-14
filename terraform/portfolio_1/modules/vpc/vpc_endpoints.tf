resource "aws_vpc_endpoint" "cloudwatch_logs" {
  count              = local.vpc_should_create && length(var.cloudwatch_logs_endpoint_subnet_ids) > 0 ? 1 : 0
  vpc_id             = local.vpc_id_effective
  service_name       = "com.amazonaws.${var.region}.logs"
  vpc_endpoint_type  = "Interface"
  subnet_ids         = var.cloudwatch_logs_endpoint_subnet_ids
  security_group_ids = var.ssm_endpoint_sg_ids

  tags = merge(var.merged_tags, {
    Name = "${var.name_prefix}-cloudwatch-logs-endpoint-${var.name_suffix}"
  })
}

resource "aws_vpc_endpoint" "cloudwatch_monitoring" {
  count              = local.vpc_should_create && length(var.cloudwatch_logs_endpoint_subnet_ids) > 0 ? 1 : 0
  vpc_id             = local.vpc_id_effective
  service_name       = "com.amazonaws.${var.region}.monitoring"
  vpc_endpoint_type  = "Interface"
  subnet_ids         = var.cloudwatch_logs_endpoint_subnet_ids
  security_group_ids = var.ssm_endpoint_sg_ids

  tags = merge(var.merged_tags, {
    Name = "${var.name_prefix}-cloudwatch-monitoring-endpoint-${var.name_suffix}"
  })
}

resource "aws_vpc_endpoint" "ec2" {
  count              = local.vpc_should_create && length(var.cloudwatch_logs_endpoint_subnet_ids) > 0 ? 1 : 0
  vpc_id             = local.vpc_id_effective
  service_name       = "com.amazonaws.${var.region}.ec2"
  vpc_endpoint_type  = "Interface"
  subnet_ids         = var.cloudwatch_logs_endpoint_subnet_ids
  security_group_ids = var.ssm_endpoint_sg_ids

  tags = merge(var.merged_tags, {
    Name = "${var.name_prefix}-ec2-endpoint-${var.name_suffix}"
  })
}

resource "aws_vpc_endpoint" "s3" {
  count             = local.vpc_should_create && var.vpc_ep_s3_name != "" ? 1 : 0
  vpc_id            = local.vpc_id_effective
  service_name      = "com.amazonaws.${var.region}.s3"
  vpc_endpoint_type = "Gateway"

  tags = merge(var.merged_tags, {
    Name = "${var.name_prefix}-s3-endpoint-${var.name_suffix}"
  })
}

# S3エンドポイントにルートテーブルを関連付け
resource "aws_vpc_endpoint_route_table_association" "s3" {
  count           = local.vpc_should_create && var.vpc_ep_s3_name != "" ? 1 : 0
  vpc_endpoint_id = aws_vpc_endpoint.s3[0].id
  route_table_id  = aws_route_table.private[0].id
}

resource "aws_vpc_endpoint" "ssm" {
  count              = length(var.ssm_endpoint_subnet_ids) > 0 && local.vpc_id_effective != "" ? 1 : 0
  vpc_id             = local.vpc_id_effective
  service_name       = "com.amazonaws.${var.region}.ssm"
  vpc_endpoint_type  = "Interface"
  subnet_ids         = var.ssm_endpoint_subnet_ids
  security_group_ids = var.ssm_endpoint_sg_ids

  private_dns_enabled = true

  tags = merge(var.merged_tags, {
    Name = "${var.name_prefix}-ssm-endpoint-${var.name_suffix}"
  })
}

resource "aws_vpc_endpoint" "ssmmessages" {
  count              = length(var.ssm_endpoint_subnet_ids) > 0 && local.vpc_id_effective != "" ? 1 : 0
  vpc_id             = local.vpc_id_effective
  service_name       = "com.amazonaws.${var.region}.ssmmessages"
  vpc_endpoint_type  = "Interface"
  subnet_ids         = var.ssm_endpoint_subnet_ids
  security_group_ids = var.ssm_endpoint_sg_ids

  private_dns_enabled = true

  tags = merge(var.merged_tags, {
    Name = "${var.name_prefix}-ssmmessages-endpoint-${var.name_suffix}"
  })
}

resource "aws_vpc_endpoint" "ec2messages" {
  count              = length(var.ssm_endpoint_subnet_ids) > 0 && local.vpc_id_effective != "" ? 1 : 0
  vpc_id             = local.vpc_id_effective
  service_name       = "com.amazonaws.${var.region}.ec2messages"
  vpc_endpoint_type  = "Interface"
  subnet_ids         = var.ssm_endpoint_subnet_ids
  security_group_ids = var.ssm_endpoint_sg_ids

  private_dns_enabled = true

  tags = merge(var.merged_tags, {
    Name = "${var.name_prefix}-ec2messages-endpoint-${var.name_suffix}"
  })
}

# API Gateway 用の VPC エンドポイントを作成
resource "aws_vpc_endpoint" "apigateway" {
  count               = length(var.api_gateway_endpoint_subnet_ids) > 0 && local.vpc_id_effective != "" ? 1 : 0
  vpc_id              = local.vpc_id_effective
  service_name        = "com.amazonaws.${var.region}.execute-api"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.api_gateway_endpoint_subnet_ids
  security_group_ids  = var.ssm_endpoint_sg_ids
  private_dns_enabled = true


  tags = merge(var.merged_tags, {
    Name = "${var.name_prefix}-apigateway-endpoint-${var.name_suffix}"
  })
}

# Secrets Manager 用の VPC エンドポイントを作成
resource "aws_vpc_endpoint" "secretsmanager" {
  count               = length(var.secretsmanager_endpoint_subnet_ids) > 0 && local.vpc_id_effective != "" ? 1 : 0
  vpc_id              = local.vpc_id_effective
  service_name        = "com.amazonaws.${var.region}.secretsmanager"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.secretsmanager_endpoint_subnet_ids
  security_group_ids  = var.ssm_endpoint_sg_ids
  private_dns_enabled = true


  tags = merge(var.merged_tags, {
    Name = "${var.name_prefix}-secretsmanager-endpoint-${var.name_suffix}"
  })
}
