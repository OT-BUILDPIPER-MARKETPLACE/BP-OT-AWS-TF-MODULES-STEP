module "secret-manager" {
  source                   = "OT-CLOUD-KIT/secret-manager/aws"
  version                  = "0.0.1"
  secret_name              = var.secret_name
  secret_string            = var.secret_string
  secret_description       = var.secret_description
  tags                     = var.tags
  kms_key_id               = var.kms_key_id
  rotation_lambda_arn      = var.rotation_lambda_arn
  enabled_rotation_secret  = var.enabled_rotation_secret
  automatically_after_days = var.automatically_after_days
}
