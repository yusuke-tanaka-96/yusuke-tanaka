resource "aws_security_group" "this" {
  count                  = length(var.security_groups) > 0 ? length(var.security_groups) : 0
  name                   = var.security_groups[count.index].name
  description            = var.security_groups[count.index].description
  vpc_id                 = local.vpc_id_effective
  revoke_rules_on_delete = true

  dynamic "ingress" {
    for_each = var.security_groups[count.index].ingress != null ? var.security_groups[count.index].ingress : []
    content {
      description     = ingress.value.description
      from_port       = ingress.value.from_port
      to_port         = ingress.value.to_port
      protocol        = ingress.value.protocol
      cidr_blocks     = try(ingress.value.cidr_blocks)
      security_groups = try(ingress.value.security_groups)
      prefix_list_ids = try(ingress.value.prefix_list_ids)
    }
  }

  dynamic "egress" {
    for_each = var.security_groups[count.index].egress
    content {
      description     = egress.value.description
      from_port       = egress.value.from_port
      to_port         = egress.value.to_port
      protocol        = egress.value.protocol
      cidr_blocks     = try(egress.value.cidr_blocks)
      security_groups = try(egress.value.security_groups)
      prefix_list_ids = try(egress.value.prefix_list_ids)
    }
  }

  tags = {
    Name      = var.security_groups[count.index].name
    Owner     = "NTT-Digital-Ops"
    ZeroTrust = "true"
  }
  lifecycle {
    create_before_destroy = true
  }
}

# resource "aws_security_group_rule" "ingress" {
#   for_each = {
#     for pair in flatten([
#       for sg in var.sg_modify : [
#         for rule in try(sg.ingress, []) : {
#           key   = "${sg.security_group_id}_ingress_${rule.from_port}_${rule.to_port}"
#           sg_id = sg.security_group_id
#           rule  = rule
#         }
#       ]
#       ]) : pair.key => {
#       sg_id = pair.sg_id
#       rule  = pair.rule
#     }
#   }

#   type                     = "ingress"
#   from_port                = each.value.rule.from_port
#   to_port                  = each.value.rule.to_port
#   protocol                 = each.value.rule.protocol
#   security_group_id        = each.value.sg_id
#   description              = lookup(each.value.rule, "description", null)
#   cidr_blocks              = lookup(each.value.rule, "cidr_blocks", null)
#   source_security_group_id = lookup(each.value.rule, "source_security_group_id", null)
# }


# resource "aws_security_group_rule" "egress" {
#   for_each = {
#     for pair in flatten([
#       for sg in var.sg_modify : [
#         for rule in try(sg.egress, []) : {
#           key   = "${sg.security_group_id}_egress_${rule.from_port}_${rule.to_port}"
#           sg_id = sg.security_group_id
#           rule  = rule
#         }
#       ]
#       ]) : pair.key => {
#       sg_id = pair.sg_id
#       rule  = pair.rule
#     }
#   }

#   type                     = "egress"
#   from_port                = each.value.rule.from_port
#   to_port                  = each.value.rule.to_port
#   protocol                 = each.value.rule.protocol
#   security_group_id        = each.value.sg_id
#   description              = lookup(each.value.rule, "description", null)
#   cidr_blocks              = lookup(each.value.rule, "cidr_blocks", null)
#   source_security_group_id = lookup(each.value.rule, "source_security_group_id", null)
# }
