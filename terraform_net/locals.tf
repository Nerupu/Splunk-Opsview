locals {
  azs              = formatlist("${data.aws_region.current.name}%s", distinct([for az in var.azs_list : az]))
  ops_net          = tolist([for cidr in data.aws_vpc_ipam_pool_cidrs.cnet.ipam_pool_cidrs : cidr.cidr if cidr.state == "provisioned"])[0]
  netmask          = split("/", local.ops_net)[1]
  privt_netmask    = var.privt_netmask
  intra_netmask    = var.intra_netmask
  database_netmask = var.database_netmask
  private_num      = var.private_num
  database_num     = var.database_num
  intra_num        = var.intra_num
  total_sub_num    = local.private_num + local.database_num + local.intra_num
  new_bits = tolist(concat(
    [for k in range(local.private_num) : local.privt_netmask],
    [for k in range(local.database_num) : local.database_netmask],
    [for k in range(local.intra_num) : local.intra_netmask]
  ))

  private_subnets  = [for k in range(local.total_sub_num) : cidrsubnets(local.ops_net, local.new_bits...)[k] if k < local.private_num]
  database_subnets = [for k in range(local.total_sub_num) : cidrsubnets(local.ops_net, local.new_bits...)[k] if local.private_num <= k && k < (local.private_num + local.database_num)]
  intra_subnets    = [for k in range(local.total_sub_num) : cidrsubnets(local.ops_net, local.new_bits...)[k] if(local.private_num + local.database_num) <= k && k < local.total_sub_num]

  intra_subnet_tags    = var.intra_subnet_tags
  private_subnet_tags  = var.private_subnet_tags
  database_subnet_tags = var.database_subnet_tags
  tags                 = var.tags
  database_subnet_group_tags = var.database_subnet_group_tags
  account_id           = data.aws_caller_identity.current.account_id
  region               = data.aws_region.current.name
  region-suffix = {
    eu-central-1 = "eu"
    eu-west-2    = "uk"
    us-east-1    = "us"
  }
  suffix = lookup(local.region-suffix, local.region)
  zone-suffix = {
    eu-central-1 = "eu"
    eu-west-2    = "uk"
    us-east-1    = "na"
  }
  zreg = lookup(local.zone-suffix, local.region)
  hosted_zone = "${var.product}-${var.env}.${local.zreg}.${var.domain}"
}
