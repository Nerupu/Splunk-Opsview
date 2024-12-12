# output "security_group_ids" {
#   value = { for sg_name, sg_config in aws_security_group.all_security_groups : sg_name => sg_config.id }
# }

# output "security_group_names" {
#   value = { for sg_name, sg_config in aws_security_group.all_security_groups : sg_name => sg_config.name }
# }
# output "eaf_aws_serv_sec_grp_ids" {
#   value = [for sg in aws_security_group.all_security_groups : sg.value.id]
# }

output "eaf_aws_serv_sec_grp_ids" {
  description = "IDs of the eaf_aws_serv_sec_grp security groups"
  value       = [for sg in aws_security_group.eaf_aws_serv_sec_grp : sg.id]
}
output "eaf_external_sg_ids" {
  description = "IDs of the eaf_external_sg security groups"
  value       = [for sg in aws_security_group.eaf_external_sg : sg.id]
}
output "eaf_jumpbox_sg_ids" {
  description = "IDs of the eaf_jumpbox_sg security groups"
  value       = [for sg in aws_security_group.eaf_jumpbox_sg : sg.id]
}
output "eaf_pri_inflx_db_sg_ids" {
  description = "IDs of the eaf_pri_inflx_db_sg security groups"
  value       = [for sg in aws_security_group.eaf_pri_inflx_db_sg : sg.id]
}
output "eaf_pri_orc_sg_ids" {
  description = "IDs of the eaf_pri_orc_sg security groups"
  value       = [for sg in aws_security_group.eaf_pri_orc_sg : sg.id]
}
output "eaf_rds_db_sg_ids" {
  description = "IDs of the eaf-rds-db-sg security groups"
  value       = [for sg in aws_security_group.eaf-rds-db-sg : sg.id]
}
output "eaf_sec_inflx_db_sg_ids" {
  description = "IDs of the eaf_sec_inflx_db_sg security groups"
  value       = [for sg in aws_security_group.eaf_sec_inflx_db_sg : sg.id]
}
output "eaf_sec_orch_sg_ids" {
  description = "IDs of the eaf_sec_inflx_db_sg security groups"
  value       = [for sg in aws_security_group.eaf_sec_orch_sg : sg.id]
}
output "eaf_stp_stone_sg_ids" {
  description = "IDs of the eaf_sec_inflx_db_sg security groups"
  value       = [for sg in aws_security_group.eaf_stp_stone_sg : sg.id]
}
