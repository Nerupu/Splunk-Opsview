# resource "aws_kms_key" "rds_encryption_key" {
#   description             = "KMS key for RDS encryption"
#   deletion_window_in_days = 30  # You can adjust this value based on your requirements
#   is_enabled = true
#   enable_key_rotation = true
#   tags = {
#     names = "aws_rds_secrets_manager"
#   }
# }