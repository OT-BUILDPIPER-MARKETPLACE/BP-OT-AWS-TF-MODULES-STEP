module "network-skeleton" {
  source              = "OT-CLOUD-KIT/network-skeleton/aws"
  version             = "1.0.0"
  cidr_block          = var.cidr_block
  name_hz             = var.name_hz
  record_type         = var.record_type
  require_hosted_zone = var.require_hosted_zone
}
