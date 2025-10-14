# route53 module

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_route53_record.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_zone.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_hosted_zone_type"></a> [hosted\_zone\_type](#input\_hosted\_zone\_type) | Type of hosted zone: public or private | `string` | `"public"` | no |
| <a name="input_records"></a> [records](#input\_records) | List of Route53 records | <pre>list(object({<br/>    name    = string<br/>    type    = string<br/>    ttl     = optional(number)<br/>    records = optional(list(string))<br/>    alias = optional(object({<br/>      name                   = string<br/>      zone_id                = string<br/>      evaluate_target_health = optional(bool, false)<br/>    }))<br/>  }))</pre> | `[]` | no |
| <a name="input_vpc_ids"></a> [vpc\_ids](#input\_vpc\_ids) | List of VPC IDs to associate with the private hosted zone (if applicable) | `list(string)` | `[]` | no |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | 指定するホストゾーンID。指定しない場合はaws\_route53\_zone.this.zone\_idを使用。 | `string` | `""` | no |
| <a name="input_zone_name"></a> [zone\_name](#input\_zone\_name) | Route53 Hosted Zone name | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_name_servers"></a> [name\_servers](#output\_name\_servers) | n/a |
| <a name="output_zone_id"></a> [zone\_id](#output\_zone\_id) | The ID of the hosted zone |
| <a name="output_zone_name"></a> [zone\_name](#output\_zone\_name) | The name of the hosted zone |
<!-- END_TF_DOCS -->
