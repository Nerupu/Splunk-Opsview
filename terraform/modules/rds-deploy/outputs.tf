output "opsview_instances" {
  description = "RDS configuration output: name, endpoint, username."
  value = tomap({"db_name" = "${aws_db_instance.opsview.db_name}",
                 "db_endpoint" = "${aws_db_instance.opsview.endpoint}",
                 "db_username" = "${aws_db_instance.opsview.username}"
                })
}