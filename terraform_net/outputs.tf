output "vpc_id" {
  value = module.ipam_vpc.vpc_id
}

output "az" {
  value = module.ipam_vpc.azs
}

output "private_tier1_subnets" {
  value = module.ipam_vpc.private_subnets
}

output "public_subnets" {
  value = module.ipam_vpc.public_subnets
}

output "database_subnets" {
  value = module.ipam_vpc.database_subnets
}
output "private_zonename" {
  value = aws_route53_zone.private.name
}

output "private_zoneid" {
  value = aws_route53_zone.private.id
}




