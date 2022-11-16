variable "cluster_name" {
  description = "EKS cluster name"
  default     = "terraform-eks-demo"
  type        = string
}

variable "cluster_autoscaler" {
  description = "For Cluster Cluster Autoscalling"
  default     = true
  type        = bool
}

variable "metrics_server" {
  description = "For Metrics Server"
  default     = true
  type        = bool
}

variable "k8s-spot-termination-handler" {
  description = "For Spot Instance termination handler"
  default     = true
  type        = bool
}

variable "eks_node_group_name" {
  description = "Node group name for EKS"
  default     = "eks-node-group"
  type        = string
}

variable "region" {
  description = "AWS region"
  default     = "us-east-1"
  type        = string
}

variable "subnets" {
  description = "A list of subnets for worker nodes"
  type        = list(string)
}

variable "eks_cluster_version" {
  description = "Kubernetes cluster version in EKS"
  type        = string
}

variable "disk_size" {
  description = "Disk size of workers"
  type        = number
  default     = 20
}

variable "scale_min_size" {
  description = "Minimum count of workers"
  type        = number
  default     = 2
}

variable "scale_max_size" {
  description = "Maximum count of workers"
  type        = number
  default     = 5
}

variable "scale_desired_size" {
  description = "Desired count of workers"
  type        = number
  default     = 3
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "config_output_path" {
  description = "kubeconfig output path"
  type        = string
}

variable "kubeconfig_name" {
  description = "Name of kubeconfig file"
  type        = string
}

variable "endpoint_private" {
  description = "endpoint private"
  type = bool
}
variable "endpoint_public" {
  description = "endpoint public"
  type = bool
}

variable "slackUrl" {
  description = "Slack Web hook URL"
  type = string
  default = ""
}

variable "vpc_id" {
  description = "VPC ID"
  type = string
}

variable "create_node_group" {
  description = "Create node group or not"
  type        = bool
  default     = true
}

variable "allow_eks_cidr" {
  description = "allow eks cidr"
  type = list(string)
  default = ["0.0.0.0/32"]
}

variable "force_update_version" {
  type        = bool
  description = "Force version update if existing pods are unable to be drained due to a pod disruption budget issue."
  default     = false
}

variable "cluster_endpoint_whitelist" {
  type = bool
  description = "For Wihtelist the cluster endpoint"
  default = false
}

variable "cluster_endpoint_access_cidrs" {
  type = list(string)
  description = "For list of cidr to whitelist"
  default = []
}

variable "enabled_cluster_log_types" {
description = "List of the desired control plane logging to enable"
type = list(string)
default = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
}

variable "eks_subnets" {
description = "subnets for eks"
type = list(string)
}

variable "ssh_key"{
description = "ssh-key for worker nodes"
type = string
}

variable "node_sg" {
description = "node security group"
type = list(string)
}

variable "instance_type" {
description = "Instance type"
type = list(string)
}

variable "desired_capacity" {
description = "Instance desired capacity"
type = number
}

variable "max_capacity" {
description = "worker node max capacity"
type = number
}

variable "min_capacity" {
description = "worker node min capacity"
type = number
}

variable "capacity_type" {
description = "capacity type of worker node 1"
type = string
}

variable "capacity_type_2" {
description = "capacity types of worker node 2"
type = string
}
