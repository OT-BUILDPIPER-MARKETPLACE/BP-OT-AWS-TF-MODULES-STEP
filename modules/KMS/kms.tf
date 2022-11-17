module "kms" {
  source  = "OT-CLOUD-KIT/kms/aws"
  version = "1"
  alias_name = var.alias_name
  deletion_window_in_days = var.deletion_window_in_days
  is_enabled = var.is_enabled
  enable_key_rotation = var.enable_key_rotation
  tags = var.tags
  kms_policy = var.kms_policy
}
