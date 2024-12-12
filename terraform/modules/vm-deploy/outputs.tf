output "opsview_instances" {
  description = "The name, ID and dns of the EC2 instances."
  value       = tomap({"type"= "${aws_instance.opsview_vm.tags.Type}",
                      "instance_id" = "${aws_instance.opsview_vm.id}",
                      "private_dns" = "${aws_instance.opsview_vm.private_dns}",
                      "private_ip" = "${aws_instance.opsview_vm.private_ip}"
                    })
}

output "volumes_config" {
  description = "Volumes configuration data: instance id, disks."
  value       = length(var.data_volumes_conf) != 0 ? [{"instance_id": "${aws_instance.opsview_vm.id}", "disks": "${var.data_volumes_conf}"}] : []
}