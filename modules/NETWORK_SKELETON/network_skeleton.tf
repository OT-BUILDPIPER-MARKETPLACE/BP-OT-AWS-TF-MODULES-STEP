module "vpc" {
  source                                               = "OT-CLOUD-KIT/vpc/aws"
  version                                              = "1.0.0"
  alb_certificate_arn                                  = var.alb_certificate_arn
  alb_name                                             = var.alb_name
  avaialability_zones                                  = var.avaialability_zones
  igw_name                                             = var.igw_name
  logs_bucket                                          = var.logs_bucket
  logs_bucket_arn                                      = var.logs_bucket_arn
  nat_name                                             = var.nat_name
  private_subnets_cidr                                 = var.private_subnets_cidr
  pub_rt_name                                          = var.pub_rt_name
  pub_subnet_name                                      = var.pub_subnet_name
  public_subnets_cidr                                  = var.public_subnets_cidr
  public_web_sg_name                                   = var.public_web_sg_name
  pvt_rt_ame                                           = var.pvt_rt_ame
  pvt_subnet_name                                      = var.pvt_subnet_name
  pvt_zone_name                                        = var.pvt_zone_name
  alb_type                                             = var.alb_type
  cidr_block                                           = var.cidr_block
  enable_alb_logging                                   = var.enable_alb_logging
  enable_aws_route53_zone_resource                     = var.enable_aws_route53_zone_resource
  enable_deletion_protection                           = var.enable_deletion_protection
  enable_dns_hostnames                                 = var.enable_dns_hostnames
  enable_dns_support                                   = var.enable_dns_support
  enable_igw_publicRouteTable_PublicSubnets_resource   = var.enable_igw_publicRouteTable_PublicSubnets_resource
  enable_nat_privateRouteTable_PrivateSubnets_resource = var.enable_nat_privateRouteTable_PrivateSubnets_resource
  enable_pub_alb_resource                              = var.enable_pub_alb_resource
  enable_public_web_security_group_resource            = var.enable_public_web_security_group_resource
  enable_vpc_logs                                      = var.enable_vpc_logs
  instance_tenancy                                     = var.instance_tenancy
  log_destination_type                                 = var.log_destination_type
  tags                                                 = var.tags
  traffic_type                                         = var.traffic_type
  vpc_name                                             = var.vpc_name
}
