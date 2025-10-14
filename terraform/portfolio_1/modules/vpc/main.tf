# VPC作成
locals {
  vpc_should_create = var.enabled && var.vpc_cidr != ""
  vpc_id_effective  = var.vpc_id != "" ? var.vpc_id : try(aws_vpc.this[0].id, "")
}

resource "aws_vpc" "this" {
  count                = local.vpc_should_create ? 1 : 0
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(var.merged_tags, { Name = "${var.name_prefix}-vpc-${var.name_suffix}" })
}

# Publicサブネット
resource "aws_subnet" "public" {
  count                   = local.vpc_should_create ? length(var.public_subnet_cidrs) : 0
  vpc_id                  = aws_vpc.this[0].id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = element(var.azs, count.index % length(var.azs))
  map_public_ip_on_launch = true

  tags = merge(var.merged_tags, {
    Name = var.public_subnet_names[count.index]
  })
}

# Privateサブネット
resource "aws_subnet" "private" {
  count             = local.vpc_should_create ? length(var.private_subnet_cidrs) : 0
  vpc_id            = aws_vpc.this[0].id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = element(var.azs, count.index % length(var.azs))

  tags = merge(var.merged_tags, {
    Name = var.private_subnet_names[count.index]
  })
}

# Protectサブネット
resource "aws_subnet" "protect" {
  count             = local.vpc_should_create ? length(var.protect_subnet_cidrs) : 0
  vpc_id            = aws_vpc.this[0].id
  cidr_block        = var.protect_subnet_cidrs[count.index]
  availability_zone = element(var.azs, count.index % length(var.azs))

  tags = merge(var.merged_tags,
    { Name = var.protect_subnet_names[count.index]
  })
}

# IGW
resource "aws_internet_gateway" "this" {
  count  = local.vpc_should_create && var.igw_name != "" ? 1 : 0
  vpc_id = aws_vpc.this[0].id

  tags = merge(var.merged_tags, { Name = var.igw_name })
}

# Elastic IP for NAT
resource "aws_eip" "nat" {
  count  = local.vpc_should_create && length(var.nat_gateway_subnet_ids) > 0 ? 1 : 0
  domain = "vpc"

  tags = merge(var.merged_tags, { Name = "${var.name_prefix}-eip-nat-${var.name_suffix}-${count.index + 1}"
  })
}

# NAT Gateway
resource "aws_nat_gateway" "this" {
  count         = local.vpc_should_create && length(var.nat_gateway_subnet_ids) > 0 ? length(var.nat_gateway_subnet_ids) : 0
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = var.nat_gateway_subnet_ids[count.index]

  tags = merge(var.merged_tags, {
    Name = "${var.name_prefix}-nat-gateway-${var.name_suffix}-${count.index + 1}"
  })
}

# Publicルートテーブル
resource "aws_route_table" "public" {
  count  = local.vpc_should_create && var.igw_name != "" ? 1 : 0
  vpc_id = aws_vpc.this[0].id

  tags = merge(
    var.merged_tags,
    {
      Name = "${var.name_prefix}-rtb-public-${var.name_suffix}"
    }
  )
}

# パブリックサブネット用ルート（0.0.0.0/0 を IGW に向ける）
resource "aws_route" "public_internet" {
  count                  = local.vpc_should_create && var.igw_name != "" ? 1 : 0
  route_table_id         = aws_route_table.public[0].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = length(aws_internet_gateway.this) > 0 ? aws_internet_gateway.this[0].id : null
}

# パブリックサブネットにルートテーブルを関連付け
resource "aws_route_table_association" "public" {
  count          = local.vpc_should_create && var.igw_name != "" ? length(aws_subnet.public) : 0
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public[0].id
}


# Privateルートテーブル
resource "aws_route_table" "private" {
  count  = local.vpc_should_create && length(aws_subnet.private) > 0 ? 1 : 0
  vpc_id = aws_vpc.this[0].id

  tags = merge(
    var.merged_tags,
    {
      Name = "${var.name_prefix}-rtb-private-${var.name_suffix}"
    }
  )
}

# Privateルート用のNAT Gateway経由のデフォルトルート
resource "aws_route" "private_nat" {
  count                  = local.vpc_should_create && length(aws_nat_gateway.this) > 0 ? 1 : 0
  route_table_id         = aws_route_table.private[0].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = length(aws_nat_gateway.this) > 0 ? aws_nat_gateway.this[0].id : null
}

# Privateサブネットとルートテーブルの関連付け
resource "aws_route_table_association" "private" {
  count          = local.vpc_should_create && length(aws_subnet.private) > 0 ? length(aws_subnet.private) : 0
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[0].id
}


# VPC Flow Logs作成
resource "aws_flow_log" "vpc" {
  count = local.vpc_should_create && var.s3_log_bucket_arn != "" ? 1 : 0
  # iam_role_arn         = var.iam_role_arn
  log_destination      = "${var.s3_log_bucket_arn}/${var.s3_log_prefix}"
  log_destination_type = "s3"
  traffic_type         = "ALL"
  vpc_id               = aws_vpc.this[0].id

  log_format = "$${account-id} $${action} $${interface-id} $${srcaddr} $${dstaddr} $${srcport} $${dstport} $${protocol} $${packets} $${bytes} $${start} $${end} $${log-status} $${region} $${version} $${tcp-flags} $${flow-direction} $${traffic-path} $${vpc-id} $${subnet-id} $${instance-id} $${pkt-srcaddr} $${pkt-dstaddr} $${pkt-src-aws-service} $${pkt-dst-aws-service}"

  tags = merge(var.merged_tags, {
    Name = "${var.name_prefix}-flow-log-${var.name_suffix}"
  })
}

# VPC Flow Logs作成
resource "aws_flow_log" "vpc-s3" {
  count                = local.vpc_should_create && var.flow_log_bucket != "" ? 1 : 0
  log_destination      = var.flow_log_bucket
  log_destination_type = "s3"
  traffic_type         = "ALL"
  vpc_id               = aws_vpc.this[0].id

  tags = merge(var.merged_tags, {
    Name = "${var.name_prefix}-flow-log-${var.name_suffix}"
  })
}

resource "aws_flow_log" "vpc_cloudwatch" {
  count                = local.vpc_should_create && var.flow_log_cloudwatch != "" ? 1 : 0
  iam_role_arn         = var.iam_role_arn
  log_destination      = var.flow_log_cloudwatch
  traffic_type         = "ALL"
  vpc_id               = aws_vpc.this[0].id
  log_destination_type = "cloud-watch-logs"

  tags = merge(var.merged_tags, {
    Name = "${var.name_prefix}-flow-log-${var.name_suffix}"
  })
}

resource "aws_vpc_peering_connection" "this" {
  count       = local.vpc_should_create && var.peer_vpc_id != "" ? 1 : 0
  vpc_id      = aws_vpc.this[0].id
  peer_vpc_id = var.peer_vpc_id
  auto_accept = true

  tags = merge(var.merged_tags, {
    Name = "${var.name_prefix}-peering-${var.name_suffix}"
  })
}

# ピアリングルート（自VPC -> ピアVPCへのルート設定）
resource "aws_route" "to_peer" {
  for_each = toset(local.vpc_should_create && var.peer_vpc_id != "" ? var.peer_vpc_cidrs : [])

  route_table_id            = aws_route_table.private[0].id
  destination_cidr_block    = each.value
  vpc_peering_connection_id = aws_vpc_peering_connection.this[0].id
}

# ピアリングルート（パブリックルートにも設定する場合はオプション）
resource "aws_route" "to_peer_public" {
  for_each = toset(local.vpc_should_create && var.peer_vpc_id != "" ? var.peer_vpc_cidrs : [])

  route_table_id            = aws_route_table.public[0].id
  destination_cidr_block    = each.value
  vpc_peering_connection_id = aws_vpc_peering_connection.this[0].id
}

# ピアリングルート
resource "aws_route" "peer_to_self_private" {
  for_each       = toset(local.vpc_should_create && var.peer_vpc_id != "" ? concat(var.private_subnet_cidrs, var.public_subnet_cidrs, var.protect_subnet_cidrs) : [])
  route_table_id = var.private_route_table_id
  #destination_cidr_block = var.vpc_cidr
  destination_cidr_block    = each.value
  vpc_peering_connection_id = aws_vpc_peering_connection.this[0].id
}

resource "aws_route" "peer_to_self_public" {
  for_each       = toset(local.vpc_should_create && var.peer_vpc_id != "" ? concat(var.private_subnet_cidrs, var.public_subnet_cidrs, var.protect_subnet_cidrs) : [])
  route_table_id = var.public_route_table_id
  #destination_cidr_block = each.value
  destination_cidr_block    = each.value
  vpc_peering_connection_id = aws_vpc_peering_connection.this[0].id
}

# VPC のデフォルトセキュリティグループを「全拒否」に変更
resource "aws_default_security_group" "default" {
  count  = local.vpc_should_create ? 1 : 0
  vpc_id = aws_vpc.this[0].id # VPC ID を指定

  # すべての inbound/outbound ルールを削除して全拒否にする
  ingress = []
  egress  = []

  tags = merge(var.merged_tags, { Name = "${var.name_prefix}-default-sg-${var.name_suffix}" })
}

# Moved block for aws_default_security_group resource refactoring
moved {
  from = aws_default_security_group.default
  to   = aws_default_security_group.default[0]
}
