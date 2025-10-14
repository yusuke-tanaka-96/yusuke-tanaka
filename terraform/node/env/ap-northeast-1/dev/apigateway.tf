resource "aws_api_gateway_rest_api" "tenant_api" {
  name = "${local.name_prefix}-backend-tenant-api"
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

#--- resource --------------------------------------------------------------------------------
#/api
resource "aws_api_gateway_resource" "api" {
  rest_api_id = aws_api_gateway_rest_api.portfolio-backend-tenant-api.id
  parent_id   = aws_api_gateway_rest_api.portfolio-backend-tenant-api.root_resource_id
  path_part   = "api"
}

#-------略---------

#-----------------------------------------------------------------------------------------


resource "aws_api_gateway_authorizer" "tenant_api" {
  name                             = "${local.name_prefix}-backend-authorizer-tenant-api"
  rest_api_id                      = aws_api_gateway_rest_api.portfolio-backend-tenant-api.id
  authorizer_uri                   = "arn:aws:apigateway:ap-northeast-1:lambda:path/2015-03-31/functions/arn:aws:lambda:ap-northeast-1:${local.aws_account}:function:${local.name_prefix}-backend-lambda-tenant/invocations"
  identity_source                  = "mpf2od.request.header.x-api-key"
  authorizer_result_ttl_in_seconds = 300
  type                             = "REQUEST"
}

resource "aws_api_gateway_mpf2od" "post" {
  rest_api_id   = aws_api_gateway_rest_api.portfolio-backend-tenant-api.id
  resource_id   = aws_api_gateway_resource.network.id
  http_mpf2od   = "POST"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.tenant-api.id
  #api_key_required = true
  request_parameters = {
    "mpf2od.request.path.chain"       = true
    "mpf2od.request.path.network"     = true
    "mpf2od.request.header.x-api-key" = true
  }
}

resource "aws_api_gateway_mpf2od" "get" {
  rest_api_id   = aws_api_gateway_rest_api.portfolio-backend-tenant-api.id
  resource_id   = aws_api_gateway_resource.health.id
  http_mpf2od   = "GET"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.tenant-api.id
  #api_key_required = true
  request_parameters = {
    "mpf2od.request.header.x-api-key" = true
  }
}


resource "aws_api_gateway_vpc_link" "tenant_api" {
  name = "${local.name_prefix}-backend-vpclink-tenant-api"
  target_arns = [
    module.elb-backend-tenant-api.lb_arn
  ]
}


resource "aws_api_gateway_integration" "post" {
  rest_api_id             = aws_api_gateway_rest_api.portfolio-backend-tenant-api.id
  resource_id             = aws_api_gateway_resource.network.id
  http_mpf2od             = aws_api_gateway_mpf2od.post.http_mpf2od
  integration_http_mpf2od = "POST"
  type                    = "HTTP"
  uri                     = "https://${local.root_domain_name}/api/v1/{chain}/{network}"
  connection_type         = "VPC_LINK"
  connection_id           = aws_api_gateway_vpc_link.tenant-api.id
  request_parameters = {
    "integration.request.path.chain"        = "mpf2od.request.path.chain"
    "integration.request.path.network"      = "mpf2od.request.path.network"
    "integration.request.header.x-trace-id" = "context.authorizer.trace_id"
    "integration.request.header.x-api-key"  = "mpf2od.request.header.x-api-key"
  }
}


resource "aws_api_gateway_integration" "get" {
  rest_api_id             = aws_api_gateway_rest_api.portfolio-backend-tenant-api.id
  resource_id             = aws_api_gateway_resource.health.id
  http_mpf2od             = aws_api_gateway_mpf2od.get.http_mpf2od
  integration_http_mpf2od = "GET"
  type                    = "HTTP"
  uri                     = "https://${local.root_domain_name}/api/v1/health"
  connection_type         = "VPC_LINK"
  connection_id           = aws_api_gateway_vpc_link.tenant-api.id
}


resource "aws_api_gateway_deployment" "deployment_tenant_api" {
  rest_api_id = aws_api_gateway_rest_api.portfolio-backend-tenant-api.id

  triggers = {
    redeploy = sha1(jsonencode(concat(
      [
        aws_api_gateway_mpf2od.post.id,
        aws_api_gateway_mpf2od.get.id,
        aws_api_gateway_integration.post.id,
        aws_api_gateway_integration.get.id,
        aws_api_gateway_authorizer.tenant-api.id
      ],
      [for k, v in aws_api_gateway_integration_response.per_code_tenant : v.id],
      [for k, v in aws_api_gateway_integration_response.default_tenant_200 : v.id]
    )))
  }

  depends_on = [
    aws_api_gateway_mpf2od.post,
    aws_api_gateway_mpf2od.get,
    aws_api_gateway_integration.post,
    aws_api_gateway_integration.get,
    aws_api_gateway_authorizer.tenant-api,
    aws_api_gateway_integration_response.per_code_tenant,
    aws_api_gateway_integration_response.default_tenant_200
  ]
}

resource "aws_api_gateway_stage" "dev" {
  rest_api_id   = aws_api_gateway_rest_api.portfolio-backend-tenant-api.id
  deployment_id = aws_api_gateway_deployment.portfolio-deployment-tenant-api.id
  stage_name    = "dev"

  access_log_settings {
    destination_arn = module.cloudwatch-logs-portfolio-backend-tenant-api.log_group_arn
    format = jsonencode({
      requestId               = "$context.requestId"
      ip                      = "$context.identity.sourceIp"
      caller                  = "$context.identity.caller"
      user                    = "$context.identity.user"
      requestTime             = "$context.requestTime"
      httpMpf2od              = "$context.httpMpf2od"
      resourcePath            = "$context.resourcePath"
      path                    = "$context.path"
      accountId               = "$context.accountId"
      stage                   = "$context.stage"
      domainName              = "$context.domainName"
      domainPrefix            = "$context.domainPrefix"
      requestTimeEpoch        = "$context.requestTimeEpoch"
      integrationStatus       = "$context.integration.status"
      integrationLatency      = "$context.integration.latency"
      responseLatency         = "$context.responseLatency"
      integrationErrorMessage = "$context.integration.error"
      status                  = "$context.status"
      protocol                = "$context.protocol"
      responseLength          = "$context.responseLength"
      traceId                 = "$context.authorizer.trace_id"
    })
  }
  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_api_gateway_mpf2od_settings" "all_logging_tenant" {
  rest_api_id = aws_api_gateway_rest_api.portfolio-backend-tenant-api.id
  stage_name  = aws_api_gateway_stage.dev.stage_name

  mpf2od_path = "*/*"

  settings {
    logging_level      = "INFO"
    metrics_enabled    = true
    data_trace_enabled = false
  }
}

resource "aws_api_gateway_domain_name" "api_custom_domain" {
  domain_name              = "api.dev.tnode.io"
  regional_certificate_arn = aws_acm_certificate.api-dev-tnode-io.arn
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_base_path_mapping" "api_mapping" {
  api_id      = aws_api_gateway_rest_api.portfolio-backend-tenant-api.id
  stage_name  = aws_api_gateway_stage.dev.stage_name
  domain_name = aws_api_gateway_domain_name.api_custom_domain.domain_name
  base_path   = ""
  depends_on = [
    aws_api_gateway_domain_name.api_custom_domain
  ]
}



resource "aws_api_gateway_mpf2od_response" "per_code_tenant" {
  for_each = local.mpf2od_status_pairs_tenant

  rest_api_id = aws_api_gateway_rest_api.portfolio-backend-tenant-api.id
  resource_id = each.value.mpf2od_data.resource_id
  http_mpf2od = each.value.mpf2od_data.mpf2od
  status_code = each.value.status_code
  depends_on  = [aws_api_gateway_integration.get, aws_api_gateway_integration.post]
}

resource "aws_api_gateway_integration_response" "per_code_tenant" {
  for_each = {
    for k, v in local.mpf2od_status_pairs_tenant :
    k => v if v.status_code != "200"
  }

  rest_api_id       = aws_api_gateway_rest_api.portfolio-backend-tenant-api.id
  resource_id       = each.value.mpf2od_data.resource_id
  http_mpf2od       = each.value.mpf2od_data.mpf2od
  status_code       = each.value.status_code
  selection_pattern = "^${each.value.status_code}$"
  depends_on        = [aws_api_gateway_mpf2od_response.per_code_tenant]
}

resource "aws_api_gateway_integration_response" "default_tenant_200" {
  for_each = {
    for k, v in local.mpf2od_status_pairs_tenant :
    k => v if v.status_code == "200"
  }

  rest_api_id       = aws_api_gateway_rest_api.portfolio-backend-tenant-api.id
  resource_id       = each.value.mpf2od_data.resource_id
  http_mpf2od       = each.value.mpf2od_data.mpf2od
  status_code       = each.value.status_code
  selection_pattern = "" # 空文字列にすることでデフォルトレスポンスとして機能
  response_templates = {
    "application/json" = "$input.body"
  }
  depends_on = [aws_api_gateway_mpf2od_response.per_code_tenant]
}

locals {
  response_codes = ["200", "201", "400", "401", "403", "404", "409", "429", "500", "503", "504"]
}

locals {
  mpf2ods_tenant = {
    post = {
      resource_id     = aws_api_gateway_resource.network.id
      mpf2od          = "POST"
      path_parameters = ["chain", "network"]
    },
    get = {
      resource_id = aws_api_gateway_resource.health.id
      mpf2od      = "GET"
    }
  }

  mpf2od_status_pairs_tenant = {
    for pair in setproduct(keys(local.mpf2ods_tenant), local.response_codes) :
    "${pair[0]}_${pair[1]}" => {
      mpf2od_data = local.mpf2ods_tenant[pair[0]]
      status_code = pair[1]
    }
  }
}

# ===============================
# Lambda permission
# ===============================
resource "aws_lambda_permission" "authorizer_tenant" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = "${local.name_prefix}-backend-lambda-tenant"
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.portfolio-backend-tenant-api.execution_arn}/*/*"
}
