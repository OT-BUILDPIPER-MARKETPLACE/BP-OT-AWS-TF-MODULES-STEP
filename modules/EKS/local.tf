locals {
  common_tags        = { ENV : "QA", OWNER : "DEVOPS", PROJECT : "CATALOG_MIGRATION", COMPONENT : "EKS", COMPONENT_TYPE : "BUILDPIPER" }
  worker_group1_tags = { "name" : "worker01" }
  worker_group2_tags = { "name" : "worker02" }
}
