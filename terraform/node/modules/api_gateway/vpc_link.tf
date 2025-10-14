resource "aws_api_gateway_vpc_link" "this" {
  name        = "${var.name_prefix}-vpc-link"
  target_arns = [var.nlb_arn]
  tags        = var.merged_tags
}
