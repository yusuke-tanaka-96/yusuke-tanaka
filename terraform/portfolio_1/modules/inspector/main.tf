resource "aws_inspector2_enabler" "this" {
  account_ids    = [var.aws_account]
  resource_types = var.resource_types
}