# VPC IDを出力
output "vpc_id" {
  description = "The ID of the VPC"
  value       = local.vpc_id_effective != "" ? local.vpc_id_effective : null
}
output "vpc_name" {
  description = "The Name tag of the created VPC"
  value       = length(aws_vpc.this) > 0 ? aws_vpc.this[0].tags["Name"] : null
}
output "vpc_cidr" {
  description = "The CIDR block of the created VPC"
  value       = length(aws_vpc.this) > 0 ? aws_vpc.this[0].cidr_block : null
}

output "igw_id" {
  description = "ID of the Internet Gateway (IGW) if created"
  value       = length(aws_internet_gateway.this) > 0 ? aws_internet_gateway.this[0].id : null
}

# PublicサブネットID一覧を出力
output "public_subnet_ids" {
  description = "List of public subnet IDs created"
  value       = [for subnet in aws_subnet.public : subnet.id]
}
output "public_subnet_cidrs" {
  description = "List of CIDR blocks for the public subnets created"
  value       = [for subnet in aws_subnet.public : subnet.cidr_block]
}

# PrivateサブネットID一覧を出力
output "private_subnet_ids" {
  description = "List of IDs for Private subnets"
  value       = [for subnet in aws_subnet.private : subnet.id]
}
output "private_subnet_cidrs" {
  description = "List of CIDR blocks for the private subnets created"
  value       = [for subnet in aws_subnet.private : subnet.cidr_block]
}

# ProtectサブネットID一覧を出力
output "protect_subnet_ids" {
  description = "List of IDs for Protect subnets"
  value       = [for subnet in aws_subnet.protect : subnet.id]
}
output "protect_subnet_cidrs" {
  description = "List of CIDR blocks for the protect subnets created"
  value       = [for subnet in aws_subnet.protect : subnet.cidr_block]
}

# インターネットゲートウェイIDを出力
output "internet_gateway_id" {
  description = "ID of the Internet Gateway (IGW) if created"
  value       = length(aws_internet_gateway.this) > 0 ? aws_internet_gateway.this[0].id : null
}

# NATゲートウェイID一覧を出力
output "nat_gateway_ids" {
  description = "List of NAT Gateway IDs"
  value       = [for natgw in aws_nat_gateway.this : natgw.id]
}

output "nat_gateway_eip" {
  description = "Elastic IP of the NAT Gateway if created"
  value       = length(aws_nat_gateway.this) > 0 ? aws_eip.nat[0].public_ip : null
}

# PublicルートテーブルIDを出力
output "public_route_table_id" {
  description = "ID of the Public Route Table"
  value       = length(aws_route_table.public) > 0 ? aws_route_table.public[0].id : null
}

# PrivateルートテーブルIDを出力
output "private_route_table_id" {
  description = "ID of the Private Route Table"
  value       = length(aws_route_table.private) > 0 ? aws_route_table.private[0].id : null
}

output "security_group_ids" {
  description = "List of security group IDs created"
  value       = { for sg_name, sg_resource in aws_security_group.this : sg_name => sg_resource.id }
}

output "cloudwatch_logs_endpoint_id" {
  description = "ID of the CloudWatch Logs Endpoint"
  value       = length(aws_vpc_endpoint.cloudwatch_logs) > 0 ? aws_vpc_endpoint.cloudwatch_logs[0].id : null
}

output "cloudwatch_monitoring_endpoint_id" {
  description = "ID of the CloudWatch Monitoring Endpoint"
  value       = length(aws_vpc_endpoint.cloudwatch_monitoring) > 0 ? aws_vpc_endpoint.cloudwatch_monitoring[0].id : null
}

output "ec2_endpoint_id" {
  description = "ID of the S3 Gateway Endpoint"
  value       = length(aws_vpc_endpoint.ec2) > 0 ? aws_vpc_endpoint.ec2[0].id : null
}

output "s3_endpoint_id" {
  description = "ID of the S3 Gateway Endpoint"
  value       = length(aws_vpc_endpoint.s3) > 0 ? aws_vpc_endpoint.s3[0].id : null
}

output "ssm_endpoint_id" {
  description = "ID of the S3 Gateway Endpoint"
  value       = length(aws_vpc_endpoint.ssm) > 0 ? aws_vpc_endpoint.ssm[0].id : null
}

output "ec2messages_endpoint_id" {
  description = "ID of the S3 Gateway Endpoint"
  value       = length(aws_vpc_endpoint.ec2messages) > 0 ? aws_vpc_endpoint.ec2messages[0].id : null
}

output "apigateway_endpoint_id" {
  description = "ID of the S3 Gateway Endpoint"
  value       = length(aws_vpc_endpoint.apigateway) > 0 ? aws_vpc_endpoint.apigateway[0] : null
}

output "apigateway_endpoint_dns_name" {
  description = "The DNS name of the API Gateway VPC Endpoint"
  value       = length(aws_vpc_endpoint.apigateway) > 0 ? aws_vpc_endpoint.apigateway[0].dns_entry[0].dns_name : null
}

output "apigateway_endpoint_hosted_zone_id" {
  description = "The Hosted Zone ID of the API Gateway VPC Endpoint"
  value       = length(aws_vpc_endpoint.apigateway) > 0 ? aws_vpc_endpoint.apigateway[0].dns_entry[0].hosted_zone_id : null
}

output "api_gateway_endpoint_id" {
  description = "ID of the S3 Gateway Endpoint"
  value       = length(aws_vpc_endpoint.apigateway) > 0 ? aws_vpc_endpoint.apigateway[0].id : null
}

output "secretmanager_endpoint_id" {
  description = "ID of the S3 Gateway Endpoint"
  value       = length(aws_vpc_endpoint.secretsmanager) > 0 ? aws_vpc_endpoint.secretsmanager[0].id : null
}

output "nacl_ids" {
  description = "List of all NACL IDs created"
  value       = [for nacl in aws_network_acl.this : nacl.id]
}

output "public_nacl_id" {
  description = "ID of the Public NACL (if exists)"
  value = try(
    aws_network_acl.this[0].id,
    null
  )
}

output "private_nacl_id" {
  description = "ID of the Private NACL (if exists)"
  value = try(
    aws_network_acl.this[1].id,
    null
  )
}

output "protect_nacl_id" {
  description = "ID of the Protect NACL (if exists)"
  value = try(
    aws_network_acl.this[2].id,
    null
  )
}


output "nacl_rule_ids" {
  description = "List of NACL rule IDs created"
  value = [
    for nacl in aws_network_acl.this : {
      nacl_id       = nacl.id
      ingress_rules = [for rule in aws_network_acl_rule.ingress : rule.id if rule.network_acl_id == nacl.id]
      egress_rules  = [for rule in aws_network_acl_rule.egress : rule.id if rule.network_acl_id == nacl.id]
    }
  ]
}


output "db_sg_id" {
  description = "Security Group ID for Aurora DB"
  value = try([
    for sg in aws_security_group.this : sg.id
    if sg.tags["Name"] == var.sg_db_name
  ][0], null)
}

output "vpc_peering_connection_id" {
  description = "VPCピアリング接続のID"
  value       = length(aws_vpc_peering_connection.this) > 0 ? aws_vpc_peering_connection.this[0].id : ""
}
