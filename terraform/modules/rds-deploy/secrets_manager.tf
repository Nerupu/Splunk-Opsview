# Generate a random password
resource "random_password" "rds_password" {
  length  = 16
  special = false
  override_special = "_%@^"
}

# Create an AWS Secrets Manager secret for the random database password
resource "aws_secretsmanager_secret" "rds_password" {
  kms_key_id = data.aws_kms_alias.secrets_manager_key.target_key_id
  name       = "opsview_rds_secret_password"
  tags = {
    logical-id = "DatabaseSubnetGroup"
    Name       = "EAF_RDS_SecretManager"
    owner      = "product-team"
    Project    = "EAF Opsview"
  }
}

# Store the random database password as a secret version
resource "aws_secretsmanager_secret_version" "rds_password_version" {
  depends_on    = [aws_secretsmanager_secret.rds_password]
  secret_id     = aws_secretsmanager_secret.rds_password.id
  secret_string = random_password.rds_password.result
}