/* data "aws_subnet" "aws_subnet_id" {
  id = var.subnet_id
} */

data "aws_kms_key" "by_id" {
  key_id = var.kms_key
}
data "aws_kms_alias" "secrets_manager_key" {
  name = "alias/aws/secretsmanager"
}
data "aws_secretsmanager_secret_version" "rds_password" {
  depends_on = [aws_secretsmanager_secret_version.rds_password_version]
  secret_id  = aws_secretsmanager_secret.rds_password.id
}

data "aws_secretsmanager_secret" "rds_password_info" {
  name = aws_secretsmanager_secret.rds_password.name
}
