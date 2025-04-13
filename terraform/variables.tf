variable "zone" {
  description = "Exoscale zone"
  type        = string
  default     = "at-vie-1"
}

variable "cluster_name" {
  description = "Cluster Name"
  type        = string
  default     = "interview-gitops-sks"
}

variable "cluster_service_level" {
  description = "Service level of the SKS cluster (starter/pro)"
  type        = string
  default     = "starter"
}

variable "cluster_auto_upgrade" {
  description = "Enable cluster auto-upgrade?"
  type        = bool
  default     = false
}

variable "cluster_cni" {
  description = "CNI plugin to use (calico/cillium)"
  type        = string
  default     = "calico"
}

variable "nodepool_name" {
  description = "Name of the SKS nodepool"
  type        = string
}

variable "nodepool_instance_type" {
  description = "Instance type for the nodepool"
  type        = string
  default     = "standard.medium"
}

variable "nodepool_instance_prefix" {
  description = "Instance prefix for the nodepool"
  type        = string
}

variable "nodepool_size" {
  description = "Number of nodes in the nodepool"
  type        = number
  default     = 3
}

variable "nodepool_disk_size" {
  description = "Disk size for each node in the nodepool"
  type        = number
  default     = 50
}