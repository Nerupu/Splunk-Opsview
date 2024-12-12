locals {
  engine               = "mysql"
  engine_version       = "5.7"
  parameter_group_name = "default.mysql5.7"

  db_username = "root"
  port        = 3306

  instance_class = "db.r5.xlarge"
  storage_type   = "gp2"

  allocated_storage = 10240
  max_storage       = 13640

  backup_retention = 5
  backup_window    = "08:10-08:40"
}