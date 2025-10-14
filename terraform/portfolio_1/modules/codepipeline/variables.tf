variable "pipelines" {
  description = "List of CodePipeline definitions"
  type = list(object({
    name           = string
    role_arn       = string
    pipeline_type  = string
    execution_mode = string
    artifact_store = object({
      type     = string
      location = string
    })
    stages = list(object({
      name = string
      actions = list(object({
        name             = string
        category         = string
        owner            = string
        provider         = string
        version          = string
        region           = string
        run_order        = number
        namespace        = optional(string)
        output_artifacts = optional(list(string))
        input_artifacts  = optional(list(string))
        configuration    = map(string)
      }))
      on_failure = optional(object({
        result = string
        retry_configuration = optional(object({
          retry_mode = string
        }))
      }))
    }))
    tags = optional(map(string))
  }))
}
