locals {
  my_zone = "at-vie-1"
}

variable "key" {
  sensitive   = true
}
variable "secret" {
  sensitive   = true
}

terraform {
  required_version = ">= 1.9.0"

  required_providers {
    exoscale = {
      source  = "exoscale/exoscale"
      version = "0.64.0"
    }
  }
}

provider "exoscale" {
  key     = "${var.key}"
  secret  = "${var.secret}"
}

resource "exoscale_security_group" "sks" {
  name = "interview-gitops-sks"
}

resource "exoscale_security_group_rule" "calico_vxlan" {
  security_group_id = exoscale_security_group.sks.id
  description       = "VXLAN (Calico)"
  type              = "INGRESS"
  protocol          = "UDP"
  start_port        = 4789
  end_port          = 4789
  # (beetwen worker nodes only)
  user_security_group_id = exoscale_security_group.sks.id
}

resource "exoscale_security_group_rule" "kubelet" {
  security_group_id = exoscale_security_group.sks.id
  description       = "Kubelet"
  type              = "INGRESS"
  protocol          = "TCP"
  start_port        = 10250
  end_port          = 10250
  # (beetwen worker nodes only)
  user_security_group_id = exoscale_security_group.sks.id
}

resource "exoscale_security_group_rule" "logs_exec" {
  security_group_id = exoscale_security_group.sks.id
  description       = "Kubelet"
  type              = "INGRESS"
  protocol          = "TCP"
  start_port        = 10250
  end_port          = 10250
  cidr              = "0.0.0.0/0"
}

resource "exoscale_security_group_rule" "nodeport_tcp" {
  security_group_id = exoscale_security_group.sks.id
  description       = "Nodeport TCP services"
  type              = "INGRESS"
  protocol          = "TCP"
  start_port        = 30000
  end_port          = 32767
  # (public)
  cidr = "0.0.0.0/0"
}

resource "exoscale_security_group_rule" "nodeport_udp" {
  security_group_id = exoscale_security_group.sks.id
  description       = "Nodeport UDP services"
  type              = "INGRESS"
  protocol          = "UDP"
  start_port        = 30000
  end_port          = 32767
  # (public)
  cidr = "0.0.0.0/0"
}

resource "exoscale_sks_cluster" "cluster" {
  depends_on    = [exoscale_security_group.sks]
  zone          = local.my_zone
  name          = "interview-gitops-sks"
  service_level = "starter"
  auto_upgrade  = false
  cni           = "calico"
}

resource "exoscale_sks_nodepool" "nodepool" {
  zone               = local.my_zone
  cluster_id         = exoscale_sks_cluster.cluster.id
  name               = "interview-gitops-sks-nodepool"
  instance_type      = "standard.medium"
  instance_prefix    = "interview-gitops-default-medium"
  size               = 1
  disk_size          = 50
  security_group_ids = [exoscale_security_group.sks.id]
}