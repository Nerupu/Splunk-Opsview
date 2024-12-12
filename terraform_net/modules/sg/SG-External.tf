locals {
  eaf_aws_serv_sec_grp_sg_ids = [for k, v in aws_security_group.eaf_aws_serv_sec_grp : aws_security_group.eaf_aws_serv_sec_grp[k].id]
}
resource "aws_security_group" "eaf_external_sg" {
  depends_on = [aws_security_group.eaf_aws_serv_sec_grp["eaf_aws_serv_sec_grp"]]
  for_each = { for k, v in var.security_groups : k => v if contains(["eaf_external_sg"], k) }

  name        = each.value.name
  description = each.value.description
  vpc_id      = var.vpc_id
  dynamic "ingress" {
    for_each = toset(each.value.ingress_rules)
    content {
      description      = ingress.value.description
      from_port        = ingress.value.from_port
      to_port          = ingress.value.to_port
      protocol         = ingress.value.protocol
      cidr_blocks      = ingress.value.cidr_blocks
      security_groups = length(ingress.value.security_groups) > 0 ? ingress.value.security_groups : local.eaf_aws_serv_sec_grp_sg_ids
    }
  }
dynamic "egress" {
    for_each = var.egress_rules
    content {
      description = egress.value.description
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }
  tags = merge({ "Name" = each.value.name }, var.tags, var.sg_tags)
}
