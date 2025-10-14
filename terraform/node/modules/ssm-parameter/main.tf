# ------------------------------------------------------------
# AWS Systems Manager Parameter Store のパラメータを作成するリソース
# ------------------------------------------------------------
# resource "aws_ssm_parameter" "this" {
#   name        = var.name
#   description = var.description
#   type        = var.type
#   value       = var.value

#   overwrite = var.overwrite
#   tags      = var.tags
# }
resource "aws_ssm_parameter" "this" {
  count       = length(var.ssm_parameters) > 0 ? length(var.ssm_parameters) : 0
  name        = var.ssm_parameters[count.index].name
  description = var.ssm_parameters[count.index].description
  type        = var.ssm_parameters[count.index].type
  value       = var.ssm_parameters[count.index].value
  overwrite   = var.ssm_parameters[count.index].overwrite
}

