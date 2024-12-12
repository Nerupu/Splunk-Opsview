
module "ipam_vpc" {
  source                        = "terraform-aws-modules/vpc/aws"
  version                       = "> 5.1.1"
  name                          = "eaf-ops-${data.aws_region.current.name}"
  ipv4_ipam_pool_id             = data.aws_vpc_ipam_pool.ipam.id
  azs                           = local.azs
  cidr                          = local.ops_net
  private_subnets               = local.private_subnets
  intra_subnets                 = local.intra_subnets
  database_subnets              = local.database_subnets
  
  create_database_subnet_group  = true
  manage_default_network_acl    = false
  manage_default_route_table    = false
  manage_default_security_group = false

  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_nat_gateway     = false
  create_igw             = false
  create_egress_only_igw = false

  private_subnet_tags  = merge(local.private_subnet_tags, local.tags)
  intra_subnet_tags    = merge(local.intra_subnet_tags, local.tags)
  database_subnet_tags = merge(local.database_subnet_tags, local.tags)
  tags                 = local.tags
  database_subnet_group_name = "eaf-opsview-${local.account_id}-databasesubnetgroup"
  database_subnet_group_tags = local.database_subnet_group_tags

}

module "security_groups" {
  source          = "./modules/sg"
  tags            = var.tags
  sg_tags         = var.sg_tags
  vpc_id          = module.ipam_vpc.vpc_id
  security_groups = var.security_groups
  egress_rules    = var.egress_rules
  depends_on = [
    module.ipam_vpc

  ]

}
resource "aws_route53_zone" "private" {
  name = data.aws_route53_zone.domain.name
  vpc {
    vpc_id = module.ipam_vpc.vpc_id
  }

  tags = var.tags
}