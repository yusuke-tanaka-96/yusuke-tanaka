module "ssm_parameters" {
  source = "../../modules/ssm-parameter"

  ssm_parameters = [
    {
      name        = "aaaaaaaaaaaaaaaaaaaaa"
      description = "aaaaaaaaaaaaaaaaaaaaa"
      type        = "String"
      value       = "aaaaaaaaaaaaaaaaaaaaa"
      overwrite   = true
    },
    {
      name        = "aaaaaaaaaaaaaaaaaaaaa"
      description = "aaaaaaaaaaaaaaaaaaaaa"
      type        = "String"
      value       = "aaaaaaaaaaaaaaaaaaaaa"
      overwrite   = true
    },

    #--------------略----------------------------------




    {
      name        = "aaaaaaaaaaaaaaaaaaaaa"
      description = "aaaaaaaaaaaaaaaaaaaaa"
      type        = "String"
      value       = "aaaaaaaaaaaaaaaaaaaaa"
      overwrite   = true
    }

  ]
}

module "secrets-manager-external-rpc-url-pf2-sepolia" {
  count  = 2
  source = "../../modules/secrets_manager"

  name_prefix = local.name_prefix
  name_suffix = "external-rpc-url-pf2-sepolia-${count.index + 1}"
  description = "Url for external rpc pf2 sepolia"

  merged_tags   = local.merged_tags
  secret_string = "test"
}

module "secrets-manager-external-rpc-url-pf1-testnet" {
  count  = 2
  source = "../../modules/secrets_manager"

  name_prefix = local.name_prefix
  name_suffix = "external-rpc-url-pf1-testnet-${count.index + 1}"
  description = "Url for external rpc pf1 testnet"

  merged_tags   = local.merged_tags
  secret_string = "test"
}
