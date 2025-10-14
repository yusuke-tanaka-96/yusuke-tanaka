# ecr module

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
| [aws_ecr_repository.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_repositories"></a> [repositories](#input\_repositories) | List of ECR repository definitions | <pre>list(object({<br/>    name                 = string<br/>    image_tag_mutability = string<br/>    encryption_type      = string<br/>    kms_key              = string<br/>    scan_on_push         = bool<br/>    tags                 = map(string)<br/>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_repository_arns"></a> [repository\_arns](#output\_repository\_arns) | ECR repository ARNs |
| <a name="output_repository_urls"></a> [repository\_urls](#output\_repository\_urls) | ECR repository URLs |
<!-- END_TF_DOCS -->
