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

#resource "exoscale_security_group_rule" "logs_exec" {
#  security_group_id = exoscale_security_group.sks.id
#  description       = "Kubelet"
#  type              = "INGRESS"
#  protocol          = "TCP"
#  start_port        = 10250
#  end_port          = 10250
#  cidr              = "0.0.0.0/0"
#}

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
  zone          = var.zone
  name          = var.cluster_name
  service_level = var.cluster_service_level
  auto_upgrade  = var.cluster_auto_upgrade
  cni           = var.cluster_cni
}

resource "exoscale_sks_nodepool" "nodepool" {
  zone               = var.zone
  cluster_id         = exoscale_sks_cluster.cluster.id
  name               = var.nodepool_name
  instance_type      = var.nodepool_instance_type
  instance_prefix    = var.nodepool_instance_prefix
  size               = var.nodepool_size
  disk_size          = var.nodepool_disk_size
  security_group_ids = [exoscale_security_group.sks.id]
}

resource "exoscale_sks_kubeconfig" "sks_kubeconfig" {
  zone       = var.zone
  cluster_id = exoscale_sks_cluster.cluster.id

  user   = "admin"
  groups = ["system:masters"]

  ttl_seconds           = 3600
  early_renewal_seconds = 300
}

resource "local_sensitive_file" "sks_kubeconfig_file" {
  filename        = "${pathexpand("~/.kube/env")}/${var.cluster_name}.kubeconfig"
  content         = exoscale_sks_kubeconfig.sks_kubeconfig.kubeconfig
  file_permission = "0600"
}