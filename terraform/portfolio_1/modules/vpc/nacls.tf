resource "aws_network_acl" "this" {
  count  = length(var.nacl_rules) > 0 && local.vpc_id_effective != "" ? length(var.nacl_rules) : 0
  vpc_id = local.vpc_id_effective

  tags = {
    Name        = var.nacl_rules[count.index].name
    Description = var.nacl_rules[count.index].description
  }
}

# nacls.tf

resource "aws_network_acl_rule" "ingress" {
  # 各NACLとそのNACL内のingressルールを組み合わせたユニークなキーと値のマップを作成
  for_each = {
    for pair in flatten([
      for nacl_index, rule in var.nacl_rules : [
        for ingress_rule in rule.ingress : {
          key_id      = "${nacl_index}-${ingress_rule.rule_number}-ingress"
          nacl_id     = aws_network_acl.this[nacl_index].id
          rule_config = ingress_rule
        }
      ] if length(rule.ingress) > 0 # ingressルールがない場合はスキップ
    ]) : pair.key_id => pair
  }

  network_acl_id = each.value.nacl_id
  rule_number    = each.value.rule_config.rule_number
  egress         = false # インバウンドルール
  protocol       = each.value.rule_config.protocol
  rule_action    = each.value.rule_config.rule_action
  from_port      = each.value.rule_config.from_port
  to_port        = each.value.rule_config.to_port
  cidr_block     = each.value.rule_config.cidr_block
}

resource "aws_network_acl_rule" "egress" {
  # 各NACLとそのNACL内のegressルールを組み合わせたユニークなキーと値のマップを作成
  for_each = {
    for pair in flatten([
      for nacl_index, rule in var.nacl_rules : [
        for egress_rule in rule.egress : {
          key_id      = "${nacl_index}-${egress_rule.rule_number}-egress"
          nacl_id     = aws_network_acl.this[nacl_index].id
          rule_config = egress_rule
        }
      ] if length(rule.egress) > 0 # egressルールがない場合はスキップ
    ]) : pair.key_id => pair
  }

  network_acl_id = each.value.nacl_id
  rule_number    = each.value.rule_config.rule_number
  egress         = true # アウトバウンドルール
  protocol       = each.value.rule_config.protocol
  rule_action    = each.value.rule_config.rule_action
  from_port      = each.value.rule_config.from_port
  to_port        = each.value.rule_config.to_port
  cidr_block     = each.value.rule_config.cidr_block
}

locals {
  nacl_subnet_selector_map = {
    public  = [for subnet in aws_subnet.public : subnet.id]
    private = [for subnet in aws_subnet.private : subnet.id]
    protect = [for subnet in aws_subnet.protect : subnet.id]
  }

  nacl_rule_subnet_ids = {
    for nacl_index, rule in var.nacl_rules :
    nacl_index => coalesce(
      try(length(rule.subnet_ids) > 0 ? rule.subnet_ids : null, null),
      try(local.nacl_subnet_selector_map[rule.subnet_selector], [])
    )
  }
}


resource "aws_network_acl_association" "this" {
  for_each = {
    for pair in flatten([
      for nacl_index, subnet_ids in local.nacl_rule_subnet_ids : [
        for subnet_id in subnet_ids : {
          nacl_index = nacl_index
          subnet_id  = subnet_id
          key        = "${nacl_index}-${subnet_id}"
        }
      ]
    ]) : pair.key => pair
  }

  network_acl_id = aws_network_acl.this[each.value.nacl_index].id
  subnet_id      = each.value.subnet_id

  lifecycle {
    create_before_destroy = true
  }
}
