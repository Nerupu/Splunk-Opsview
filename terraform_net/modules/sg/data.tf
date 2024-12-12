# data "aws_security_group" "eaf_pri_orc_sg" {
#   for_each = aws_security_group.eaf_pri_orc_sg

#   name = each.value.name
# }