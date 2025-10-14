resource "aws_codepipeline" "this" {
  for_each = { for pipeline in var.pipelines : pipeline.name => pipeline }

  name           = each.value.name
  role_arn       = each.value.role_arn
  pipeline_type  = each.value.pipeline_type
  execution_mode = each.value.execution_mode

  artifact_store {
    type     = each.value.artifact_store.type
    location = each.value.artifact_store.location
  }

  dynamic "stage" {
    for_each = each.value.stages
    content {
      name = stage.value.name
      dynamic "action" {
        for_each = stage.value.actions
        content {
          name             = action.value.name
          category         = action.value.category
          owner            = action.value.owner
          provider         = action.value.provider
          version          = action.value.version
          region           = action.value.region
          run_order        = action.value.run_order
          namespace        = lookup(action.value, "namespace", null)
          output_artifacts = lookup(action.value, "output_artifacts", [])
          input_artifacts  = lookup(action.value, "input_artifacts", [])
          configuration    = action.value.configuration
        }
      }
      dynamic "on_failure" {
        for_each = stage.value.on_failure != null ? [stage.value.on_failure] : []
        content {
          result = on_failure.value.result
          dynamic "retry_configuration" {
            for_each = on_failure.value.retry_configuration != null ? [on_failure.value.retry_configuration] : []
            content {
              retry_mode = retry_configuration.value.retry_mode
            }
          }
        }
      }
    }
  }

  tags = try(each.value.tags, {})
}
