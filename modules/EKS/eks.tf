module "eks" {
  source  = "OT-CLOUD-KIT/eks/aws"
  version = "1.1.0"
  cluster_name           = var.cluster_name
  eks_cluster_version    = var.eks_cluster_version
  subnets                = var.eks_subnets
  kubeconfig_name        = var.kubeconfig_name
  config_output_path     = var.config_output_path
  region                 = var.region
  create_node_group      = true
  endpoint_private       = false
  endpoint_public        = true
  vpc_id                 = var.vpc_id
  slackUrl               = var.slackUrl
  node_groups = {
    "worker1" = {
      subnets            = var.subnets
      ssh_key            = var.ssh_key
      security_group_ids = var.node_sg
      instance_type      = var.instance_type
      desired_capacity   = var.desired_capacity
      disk_size          = var.disk_size
      max_capacity       = var.max_capacity
      min_capacity       = var.min_capacity
      capacity_type      = var.capacity_type
      tags               = merge(local.common_tags, local.worker_group1_tags)
      labels             = { "node_group" : "worker1" }
    }
   "worker2" = {
      subnets            = var.subnets
      ssh_key            = var.ssh_key
      security_group_ids = var.node_sg
      instance_type      = var.instance_type
      desired_capacity   = var.desired_capacity
      disk_size          = var.disk_size
      max_capacity       = var.max_capacity
      min_capacity       = var.min_capacity
      capacity_type      = var.capacity_type_2
      tags               = merge(local.common_tags, local.worker_group1_tags)
      labels             = { "node_group" : "worker2" }
    }
  }
}
