output "instances_list" {
  description = "The name, ID and private dns of the EC2 instances."
  value       = module.vm-deploy.*.opsview_instances
}