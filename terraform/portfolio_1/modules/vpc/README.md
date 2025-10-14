# vpc module

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
| [aws_eip.nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_flow_log.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/flow_log) | resource |
| [aws_flow_log.vpc-s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/flow_log) | resource |
| [aws_flow_log.vpc_cloudwatch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/flow_log) | resource |
| [aws_internet_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_network_acl.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl) | resource |
| [aws_network_acl_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_association) | resource |
| [aws_network_acl_rule.egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_network_acl_rule.ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_route.peer_to_self_private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.peer_to_self_public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.private_nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.public_internet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.to_peer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.to_peer_public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route_table.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_subnet.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.protect](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_vpc_endpoint.apigateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.cloudwatch_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.cloudwatch_monitoring](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.ec2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.ec2messages](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.secretsmanager](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.ssm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.ssmmessages](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint_route_table_association.s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint_route_table_association) | resource |
| [aws_vpc_peering_connection.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_peering_connection) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_gateway_endpoint_subnet_ids"></a> [api\_gateway\_endpoint\_subnet\_ids](#input\_api\_gateway\_endpoint\_subnet\_ids) | List of subnet IDs for CloudWatch Monitoring endpoint | `list(string)` | `[]` | no |
| <a name="input_azs"></a> [azs](#input\_azs) | List of Availability Zones | `list(string)` | `[]` | no |
| <a name="input_cloudwatch_logs_endpoint_subnet_ids"></a> [cloudwatch\_logs\_endpoint\_subnet\_ids](#input\_cloudwatch\_logs\_endpoint\_subnet\_ids) | List of subnet IDs for CloudWatch Logs endpoint | `list(string)` | `[]` | no |
| <a name="input_cloudwatch_subnet_ids"></a> [cloudwatch\_subnet\_ids](#input\_cloudwatch\_subnet\_ids) | List of Subnet IDs for CloudWatch and CloudWatch Logs endpoints | `list(string)` | `[]` | no |
| <a name="input_create_security_groups"></a> [create\_security\_groups](#input\_create\_security\_groups) | Whpf2er to create the security groups | `bool` | `false` | no |
| <a name="input_flow_log_bucket"></a> [flow\_log\_bucket](#input\_flow\_log\_bucket) | ARN of the S3 bucket to store VPC flow logs | `string` | `""` | no |
| <a name="input_flow_log_cloudwatch"></a> [flow\_log\_cloudwatch](#input\_flow\_log\_cloudwatch) | the Cloudwatch log group to store VPC flow logs | `string` | `""` | no |
| <a name="input_iam_role_arn"></a> [iam\_role\_arn](#input\_iam\_role\_arn) | ARN of the iam role for VPC flow logs | `string` | `""` | no |
| <a name="input_igw_name"></a> [igw\_name](#input\_igw\_name) | name of internet gateway | `string` | `""` | no |
| <a name="input_merged_tags"></a> [merged\_tags](#input\_merged\_tags) | Merged tags for resources | `map(string)` | `{}` | no |
| <a name="input_nacl_rules"></a> [nacl\_rules](#input\_nacl\_rules) | List of NACL rules to create | <pre>list(object({<br/>    name        = string<br/>    description = string<br/>    subnet_ids  = list(string)<br/>    ingress = list(object({<br/>      rule_number = number<br/>      protocol    = string<br/>      from_port   = number<br/>      to_port     = number<br/>      cidr_block  = string<br/>      rule_action = string<br/>    }))<br/>    egress = list(object({<br/>      rule_number = number<br/>      protocol    = string<br/>      from_port   = number<br/>      to_port     = number<br/>      cidr_block  = string<br/>      rule_action = string<br/>    }))<br/>  }))</pre> | `[]` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Prefix for naming resources | `string` | `""` | no |
| <a name="input_name_suffix"></a> [name\_suffix](#input\_name\_suffix) | suffix for naming resources | `string` | `""` | no |
| <a name="input_nat_gateway_subnet_ids"></a> [nat\_gateway\_subnet\_ids](#input\_nat\_gateway\_subnet\_ids) | The subnet ID for NAT Gateway. If not specified, no NAT Gateway will be created. | `list(string)` | `[]` | no |
| <a name="input_peer_vpc_cidr"></a> [peer\_vpc\_cidr](#input\_peer\_vpc\_cidr) | CIDR block of the peer VPC | `string` | `""` | no |
| <a name="input_peer_vpc_id"></a> [peer\_vpc\_id](#input\_peer\_vpc\_id) | VPC ID of the peer VPC | `string` | `""` | no |
| <a name="input_private_route_table_id"></a> [private\_route\_table\_id](#input\_private\_route\_table\_id) | private route table id | `string` | `""` | no |
| <a name="input_private_subnet_cidrs"></a> [private\_subnet\_cidrs](#input\_private\_subnet\_cidrs) | List of CIDR blocks for Private subnets | `list(string)` | `[]` | no |
| <a name="input_private_subnet_names"></a> [private\_subnet\_names](#input\_private\_subnet\_names) | List of CIDR blocks for Private subnets | `list(string)` | `[]` | no |
| <a name="input_protect_subnet_cidrs"></a> [protect\_subnet\_cidrs](#input\_protect\_subnet\_cidrs) | List of CIDR blocks for Protect subnets | `list(string)` | `[]` | no |
| <a name="input_protect_subnet_names"></a> [protect\_subnet\_names](#input\_protect\_subnet\_names) | List of CIDR blocks for Protect subnets | `list(string)` | `[]` | no |
| <a name="input_public_route_table_id"></a> [public\_route\_table\_id](#input\_public\_route\_table\_id) | public route table id | `string` | `""` | no |
| <a name="input_public_subnet_cidrs"></a> [public\_subnet\_cidrs](#input\_public\_subnet\_cidrs) | List of CIDR blocks for Public subnets | `list(string)` | `[]` | no |
| <a name="input_public_subnet_names"></a> [public\_subnet\_names](#input\_public\_subnet\_names) | List of CIDR blocks for Public subnets | `list(string)` | `[]` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | `"ap-northeast-1"` | no |
| <a name="input_s3_endpoint_subnet_ids"></a> [s3\_endpoint\_subnet\_ids](#input\_s3\_endpoint\_subnet\_ids) | List of subnet IDs for S3 Gateway endpoint | `list(string)` | `[]` | no |
| <a name="input_s3_log_bucket_arn"></a> [s3\_log\_bucket\_arn](#input\_s3\_log\_bucket\_arn) | ARN of the S3 bucket to store VPC flow logs | `string` | `""` | no |
| <a name="input_s3_log_prefix"></a> [s3\_log\_prefix](#input\_s3\_log\_prefix) | Prefix for S3 logs (VPC flow logs, etc.) | `string` | `""` | no |
| <a name="input_secretsmanager_endpoint_subnet_ids"></a> [secretsmanager\_endpoint\_subnet\_ids](#input\_secretsmanager\_endpoint\_subnet\_ids) | secrets manager endpoint subnet ids | `list(string)` | `[]` | no |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | List of security groups to create. Each group is a map with 'name', 'description', 'ingress', and 'egress'. | <pre>list(object({<br/>    name        = string<br/>    description = string<br/>    ingress = optional(list(object({<br/>      description     = string<br/>      from_port       = number<br/>      to_port         = number<br/>      protocol        = string<br/>      cidr_blocks     = optional(list(string))<br/>      security_groups = optional(list(string))<br/>      prefix_list_ids = optional(list(string))<br/>    })))<br/>    egress = list(object({<br/>      description     = string<br/>      from_port       = number<br/>      to_port         = number<br/>      protocol        = string<br/>      cidr_blocks     = optional(list(string))<br/>      security_groups = optional(list(string))<br/>      prefix_list_ids = optional(list(string))<br/>    }))<br/>  }))</pre> | `[]` | no |
| <a name="input_sg_db_name"></a> [sg\_db\_name](#input\_sg\_db\_name) | sg name of database | `string` | `""` | no |
| <a name="input_sg_modify"></a> [sg\_modify](#input\_sg\_modify) | List of security groups to modify, each with optional ingress and egress rules | <pre>list(object({<br/>    security_group_id = string<br/>    ingress = optional(list(object({<br/>      description              = optional(string)<br/>      from_port                = number<br/>      to_port                  = number<br/>      protocol                 = string<br/>      cidr_blocks              = optional(list(string))<br/>      source_security_group_id = optional(string)<br/>    })))<br/>    egress = optional(list(object({<br/>      description              = optional(string)<br/>      from_port                = number<br/>      to_port                  = number<br/>      protocol                 = string<br/>      cidr_blocks              = optional(list(string))<br/>      source_security_group_id = optional(string)<br/>    })))<br/>  }))</pre> | `[]` | no |
| <a name="input_ssm_endpoint_sg_ids"></a> [ssm\_endpoint\_sg\_ids](#input\_ssm\_endpoint\_sg\_ids) | List of SG IDs to place the SSM endpoints | `list(string)` | `[]` | no |
| <a name="input_ssm_endpoint_subnet_ids"></a> [ssm\_endpoint\_subnet\_ids](#input\_ssm\_endpoint\_subnet\_ids) | List of subnet IDs to place the SSM endpoints | `list(string)` | `[]` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | CIDR block for the VPC | `string` | `""` | no |
| <a name="input_vpc_ep_s3_name"></a> [vpc\_ep\_s3\_name](#input\_vpc\_ep\_s3\_name) | name of vpc endpoint s3 | `string` | `""` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID where the security groups will be created | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_api_gateway_endpoint_id"></a> [api\_gateway\_endpoint\_id](#output\_api\_gateway\_endpoint\_id) | ID of the S3 Gateway Endpoint |
| <a name="output_apigateway_endpoint_id"></a> [apigateway\_endpoint\_id](#output\_apigateway\_endpoint\_id) | ID of the S3 Gateway Endpoint |
| <a name="output_cloudwatch_logs_endpoint_id"></a> [cloudwatch\_logs\_endpoint\_id](#output\_cloudwatch\_logs\_endpoint\_id) | ID of the CloudWatch Logs Endpoint |
| <a name="output_cloudwatch_monitoring_endpoint_id"></a> [cloudwatch\_monitoring\_endpoint\_id](#output\_cloudwatch\_monitoring\_endpoint\_id) | ID of the CloudWatch Monitoring Endpoint |
| <a name="output_db_sg_id"></a> [db\_sg\_id](#output\_db\_sg\_id) | Security Group ID for Aurora DB |
| <a name="output_ec2_endpoint_id"></a> [ec2\_endpoint\_id](#output\_ec2\_endpoint\_id) | ID of the S3 Gateway Endpoint |
| <a name="output_ec2messages_endpoint_id"></a> [ec2messages\_endpoint\_id](#output\_ec2messages\_endpoint\_id) | ID of the S3 Gateway Endpoint |
| <a name="output_igw_id"></a> [igw\_id](#output\_igw\_id) | ID of the Internet Gateway (IGW) if created |
| <a name="output_internet_gateway_id"></a> [internet\_gateway\_id](#output\_internet\_gateway\_id) | ID of the Internet Gateway (IGW) if created |
| <a name="output_nacl_ids"></a> [nacl\_ids](#output\_nacl\_ids) | List of all NACL IDs created |
| <a name="output_nacl_rule_ids"></a> [nacl\_rule\_ids](#output\_nacl\_rule\_ids) | List of NACL rule IDs created |
| <a name="output_nat_gateway_eip"></a> [nat\_gateway\_eip](#output\_nat\_gateway\_eip) | Elastic IP of the NAT Gateway if created |
| <a name="output_nat_gateway_ids"></a> [nat\_gateway\_ids](#output\_nat\_gateway\_ids) | List of NAT Gateway IDs |
| <a name="output_private_nacl_id"></a> [private\_nacl\_id](#output\_private\_nacl\_id) | ID of the Private NACL (if exists) |
| <a name="output_private_route_table_id"></a> [private\_route\_table\_id](#output\_private\_route\_table\_id) | ID of the Private Route Table |
| <a name="output_private_subnet_cidrs"></a> [private\_subnet\_cidrs](#output\_private\_subnet\_cidrs) | List of CIDR blocks for the private subnets created |
| <a name="output_private_subnet_ids"></a> [private\_subnet\_ids](#output\_private\_subnet\_ids) | List of IDs for Private subnets |
| <a name="output_protect_nacl_id"></a> [protect\_nacl\_id](#output\_protect\_nacl\_id) | ID of the Protect NACL (if exists) |
| <a name="output_protect_subnet_cidrs"></a> [protect\_subnet\_cidrs](#output\_protect\_subnet\_cidrs) | List of CIDR blocks for the protect subnets created |
| <a name="output_protect_subnet_ids"></a> [protect\_subnet\_ids](#output\_protect\_subnet\_ids) | List of IDs for Protect subnets |
| <a name="output_public_nacl_id"></a> [public\_nacl\_id](#output\_public\_nacl\_id) | ID of the Public NACL (if exists) |
| <a name="output_public_route_table_id"></a> [public\_route\_table\_id](#output\_public\_route\_table\_id) | ID of the Public Route Table |
| <a name="output_public_subnet_cidrs"></a> [public\_subnet\_cidrs](#output\_public\_subnet\_cidrs) | List of CIDR blocks for the public subnets created |
| <a name="output_public_subnet_ids"></a> [public\_subnet\_ids](#output\_public\_subnet\_ids) | List of public subnet IDs created |
| <a name="output_s3_endpoint_id"></a> [s3\_endpoint\_id](#output\_s3\_endpoint\_id) | ID of the S3 Gateway Endpoint |
| <a name="output_secretmanager_endpoint_id"></a> [secretmanager\_endpoint\_id](#output\_secretmanager\_endpoint\_id) | ID of the S3 Gateway Endpoint |
| <a name="output_security_group_ids"></a> [security\_group\_ids](#output\_security\_group\_ids) | List of security group IDs created |
| <a name="output_ssm_endpoint_id"></a> [ssm\_endpoint\_id](#output\_ssm\_endpoint\_id) | ID of the S3 Gateway Endpoint |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of the VPC |
| <a name="output_vpc_name"></a> [vpc\_name](#output\_vpc\_name) | The Name tag of the created VPC |
| <a name="output_vpc_peering_connection_id"></a> [vpc\_peering\_connection\_id](#output\_vpc\_peering\_connection\_id) | VPCピアリング接続のID |
<!-- END_TF_DOCS -->
