# guard_duty module

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
| [aws_guardduty_detector.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/guardduty_detector) | resource |
| [aws_guardduty_publishing_destination.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/guardduty_publishing_destination) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_destination_s3_arn"></a> [destination\_s3\_arn](#input\_destination\_s3\_arn) | ARN of the S3 bucket for publishing GuardDuty findings | `string` | `""` | no |
| <a name="input_enable_detector"></a> [enable\_detector](#input\_enable\_detector) | Whpf2er to enable the GuardDuty detector | `bool` | `true` | no |
| <a name="input_enable_eks_protection"></a> [enable\_eks\_protection](#input\_enable\_eks\_protection) | Whpf2er to enable EKS audit log protection | `bool` | `false` | no |
| <a name="input_enable_malware_protection"></a> [enable\_malware\_protection](#input\_enable\_malware\_protection) | Whpf2er to enable malware protection for EC2 instances | `bool` | `false` | no |
| <a name="input_enable_publishing_destination"></a> [enable\_publishing\_destination](#input\_enable\_publishing\_destination) | Whpf2er to enable publishing GuardDuty findings to an S3 bucket | `bool` | `false` | no |
| <a name="input_enable_s3_protection"></a> [enable\_s3\_protection](#input\_enable\_s3\_protection) | Whpf2er to enable S3 data source protection | `bool` | `true` | no |
| <a name="input_kms_key_arn"></a> [kms\_key\_arn](#input\_kms\_key\_arn) | Optional KMS key ARN for encrypting GuardDuty findings | `string` | `""` | no |
| <a name="input_merged_tags"></a> [merged\_tags](#input\_merged\_tags) | Common tags to apply to GuardDuty resources | `map(string)` | `{}` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Prefix for resource names (e.g., environment or project) | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_detector_id"></a> [detector\_id](#output\_detector\_id) | ID of the GuardDuty detector |
<!-- END_TF_DOCS -->
