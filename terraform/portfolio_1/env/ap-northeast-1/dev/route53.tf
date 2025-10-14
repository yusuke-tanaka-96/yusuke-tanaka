locals {
  root_domain_name               = "portfolio.com"
  domain_name_private            = "portfolio-praivate.com"
  testnet_pf2_prefix_domain_name = "sepolia-pf2"
  testnet_pf1_prefix_domain_name = "testnet-pf1"
}

#################################################################
#root host zone
#################################################################
module "route53_root_hostzone" {
  source = "../../modules/route53"

  zone_name        = local.root_domain_name
  hosted_zone_type = "public"
  vpc_ids          = []

  records = [
    {
      name = "api.dev"
      type = "A"
      alias = {
        name                   = aws_api_gateway_domain_name.api_custom_domain.regional_domain_name
        zone_id                = aws_api_gateway_domain_name.api_custom_domain.regional_zone_id
        evaluate_target_health = true
      }
    },
    {
      name = "tenant-api"
      type = "A"
      alias = {
        name                   = module.elb-backend-tenant-api.lb_dns_name
        zone_id                = module.elb-backend-tenant-api.lb_zone_id
        evaluate_target_health = true
      }
    },
    {
      name = "internal-api"
      type = "A"
      alias = {
        name                   = module.elb-backend-internal-api.lb_dns_name
        zone_id                = module.elb-backend-internal-api.lb_zone_id
        evaluate_target_health = true
      }
    }
  ]
}

module "acm_public_lb" {
  source = "../../modules/acm"

  name_prefix    = local.name_prefix
  hosted_zone_id = module.route53_root_hostzone.zone_id

  domain_name               = "internal.dev.tnode.io"
  subject_alternative_names = ["*.internal.dev.tnode.io"]

  merged_tags = merge(local.merged_tags, {
    Owner = "dev"
  })
}

module "acm_public_apigateway" {
  source = "../../modules/acm"

  name_prefix    = local.name_prefix
  hosted_zone_id = module.route53_root_hostzone.zone_id

  domain_name               = "api.dev.tnode.io"
  subject_alternative_names = ["*.api.dev.tnode.io"]

  merged_tags = merge(local.merged_tags, {
    Owner = "dev"
  })
}

#################################################################
#private host zone
#################################################################
module "pca_root" {
  source = "../../modules/private-ca"

  is_root             = true
  subject_common_name = "tnode.io"
  acm_source_account  = local.aws_account
}

module "route53_private_hostzone" {
  source = "../../modules/route53"

  zone_name        = local.domain_name_private
  hosted_zone_type = "private"
  vpc_ids = [
    module.vpc-backend.vpc_id,
    module.vpc-testnet-pf1.vpc_id,
    module.vpc-testnet-pf2.vpc_id
  ]

  records = [
    {
      name = local.testnet_pf1_prefix_domain_name
      type = "A"
      alias = {
        name                   = module.ec2-testnet-pf1-rpc.lb_dns_name
        zone_id                = module.ec2-testnet-pf1-rpc.lb_zone_id
        evaluate_target_health = true
      }
    },
    {
      name = local.testnet_pf2_prefix_domain_name
      type = "A"
      alias = {
        name                   = module.ec2-testnet-pf2-rpc.lb_dns_name
        zone_id                = module.ec2-testnet-pf2-rpc.lb_zone_id
        evaluate_target_health = true
      }
    },
    {
      name = "internal-api"
      type = "A"
      alias = {
        name                   = module.vpc-backend.apigateway_endpoint_dns_name
        zone_id                = module.vpc-backend.apigateway_endpoint_hosted_zone_id
        evaluate_target_health = true
      }
    }
  ]
}

module "acm_private_api_lb" {
  source = "../../modules/acm"

  name_prefix = local.name_prefix

  domain_name               = "internal.dev.tnode.io"
  subject_alternative_names = ["*.internal.dev.tnode.io"]

  certificate_authority_arn = module.pca_root.ca_arn

  merged_tags = merge(local.merged_tags, {
    Owner = "dev"
  })
}
