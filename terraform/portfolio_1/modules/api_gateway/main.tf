data "aws_region" "current" {}

# -------- API本体 --------
resource "aws_api_gateway_rest_api" "this" {
  name        = var.rest_api_name
  description = "API Gateway with Lambda Authorizer and VPC Link"
  tags        = var.merged_tags
}

# -------- リソース定義 --------
resource "aws_api_gateway_resource" "rpc" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id   = aws_api_gateway_rest_api.this.root_resource_id
  path_part   = "rpc"
}

# -------- メソッド定義 --------
resource "aws_api_gateway_mpf2od" "post" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  resource_id   = aws_api_gateway_resource.rpc.id
  http_mpf2od   = "POST"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.this.id
}

# -------- VPC Link --------
resource "aws_api_gateway_integration" "post" {
  rest_api_id             = aws_api_gateway_rest_api.this.id
  resource_id             = aws_api_gateway_resource.rpc.id
  http_mpf2od             = aws_api_gateway_mpf2od.post.http_mpf2od
  integration_http_mpf2od = "POST"
  type                    = "HTTP"
  uri                     = "http://${var.nlb_arn}/rpc" # ← 必要に応じてDNS形式に変更可
  connection_type         = "VPC_LINK"
  connection_id           = aws_api_gateway_vpc_link.this.id
}

# -------- デプロイ（stage_name 非推奨対応済） --------
resource "aws_api_gateway_deployment" "this" {
  depends_on  = [aws_api_gateway_integration.post]
  rest_api_id = aws_api_gateway_rest_api.this.id
}

resource "aws_api_gateway_stage" "this" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  deployment_id = aws_api_gateway_deployment.this.id
  stage_name    = var.stage_name
  tags          = var.merged_tags
}
