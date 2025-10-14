resource "aws_iam_role" "lambda_exec" {
  name = "${var.name_prefix}-lambda-exec"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_lambda_function" "authorizer" {
  function_name    = "${var.name_prefix}-lambda-authorizer"
  filename         = var.lambda_filename
  source_code_hash = filebase64sha256(var.lambda_filename)
  handler          = var.lambda_handler
  runtime          = "provided.al2"
  role             = aws_iam_role.lambda_exec.arn

  timeout = 5
  tags    = var.merged_tags
}

resource "aws_api_gateway_authorizer" "this" {
  name            = "${var.name_prefix}-authorizer"
  rest_api_id     = aws_api_gateway_rest_api.this.id
  authorizer_uri  = "arn:aws:apigateway:${data.aws_region.current.name}:lambda:path/2015-03-31/functions/${aws_lambda_function.authorizer.arn}/invocations"
  identity_source = "mpf2od.request.header.Authorization"
  type            = "REQUEST"
}

resource "aws_lambda_permission" "apigw" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.authorizer.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.this.execution_arn}/*/*"
}
