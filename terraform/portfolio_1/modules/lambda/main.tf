locals {
  lambda_enabled = var.enabled
  invoke_permissions_map = {
    for p in var.invoke_permissions : p.statement_id => p
  }
}

resource "aws_lambda_function" "this" {
  count = local.lambda_enabled ? 1 : 0

  function_name     = var.function_name
  role              = var.iam_role_arn
  handler           = var.handler
  runtime           = var.runtime
  architectures     = var.architectures
  package_type      = var.package_type
  filename          = var.local_zip_path != "" ? var.local_zip_path : null
  source_code_hash  = var.local_zip_path != "" ? filebase64sha256(var.local_zip_path) : null
  s3_bucket         = var.local_zip_path == "" ? var.s3_bucket : null
  s3_key            = var.local_zip_path == "" ? var.s3_key : null
  s3_object_version = var.local_zip_path == "" ? var.s3_object_version : null
  layers            = var.layer_arns

  environment {
    variables = { for env in var.environment_variables : env.name => env.value }
  }

  timeout                        = var.timeout
  memory_size                    = var.memory_size
  reserved_concurrent_executions = var.reserved_concurrent_executions
  skip_destroy                   = var.skip_destroy

  ephemeral_storage {
    size = var.phemeral_storage_size
  }

  vpc_config {
    subnet_ids                  = var.subnet_ids
    security_group_ids          = var.security_group_ids
    ipv6_allowed_for_dual_stack = false
  }

  tracing_config {
    mode = "PassThrough"
  }

  logging_config {
    log_format = "Text"
    log_group  = var.log_group
  }

  tags = var.merged_tags

  lifecycle {
    ignore_changes = [
      filename,
      layers,
    ]
  }
}

resource "aws_lambda_permission" "this" {
  for_each = local.lambda_enabled ? local.invoke_permissions_map : {}

  statement_id  = each.value.statement_id
  action        = coalesce(each.value.action, "lambda:InvokeFunction")
  function_name = aws_lambda_function.this[0].function_name
  principal     = each.value.principal

  source_arn     = try(each.value.source_arn, null)
  source_account = try(each.value.source_account, null)
  qualifier      = try(each.value.qualifier, null)
}
