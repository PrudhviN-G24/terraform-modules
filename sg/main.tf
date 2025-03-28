resource "aws_security_group" "this" {
  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id

  tags = merge({
    Name = var.name
  }, var.tags)
}

resource "aws_security_group_rule" "ingress" {
  for_each = { for idx, rule in var.ingress_rules : idx => rule }

  type              = "ingress"
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  security_group_id = aws_security_group.this.id

  cidr_blocks       = lookup(each.value, "cidr_blocks", [])
  ipv6_cidr_blocks  = lookup(each.value, "ipv6_cidr_blocks", [])
  source_security_group_id = length(lookup(each.value, "security_groups", [])) > 0 ? element(each.value.security_groups, 0) : null
  description       = lookup(each.value, "description", null)
}

resource "aws_security_group_rule" "egress" {
  for_each = { for idx, rule in var.egress_rules : idx => rule }

  type              = "egress"
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  security_group_id = aws_security_group.this.id

  cidr_blocks       = lookup(each.value, "cidr_blocks", [])
  ipv6_cidr_blocks  = lookup(each.value, "ipv6_cidr_blocks", [])
  source_security_group_id = length(lookup(each.value, "security_groups", [])) > 0 ? element(each.value.security_groups, 0) : null
  description       = lookup(each.value, "description", null)
}
