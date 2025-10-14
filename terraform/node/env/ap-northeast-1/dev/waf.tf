module "waf" {
  source              = "../../modules/waf"
  name_prefix         = local.name_prefix
  name_suffix         = "waf"
  scope               = "REGIONAL"
  enable_managed_rule = true
  enable_rate_limit   = true
  rate_limit          = 9000
  enable_association  = true
  associate_arn       = local.waf_associate_arn

  whitelist_ips = []

  custom_rules = [
    {
      name             = "allow_pf1_api_access"
      path_starts_with = "/api/v1/pf1/"
      priority         = 6
      default_action   = "allow"
    },
    {
      name             = "allow_pf2_api_access"
      path_starts_with = "/api/v1/pf2/"
      priority         = 7
      default_action   = "allow"
    }
  ]

  merged_tags = merge(local.merged_tags, {
    Name = "${local.name_prefix}-waf"
  })
}
