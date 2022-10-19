variable "key" {
  sensitive   = true
}
variable "secret" {
  sensitive   = true
}

terraform {
  required_version = ">= 1.0.0"

  required_providers {
    exoscale = {
      source  = "exoscale/exoscale"
      version = "0.37.1"
    }
  }
}

provider "exoscale" {
  key     = "${var.key}"
  secret  = "${var.secret}"
}

resource "exoscale_security_group" "sks" {
  name = "dev-sks"
}

resource "exoscale_security_group_rules" "sks" {
  security_group = exoscale_security_group.sks.name

  ingress {
    description              = "Calico traffic"
    protocol                 = "UDP"
    ports                    = ["4789"]
    user_security_group_list = [exoscale_security_group.sks.name]
  }

  ingress {
    description = "Nodes logs/exec"
    protocol    = "TCP"
    ports       = ["10250"]
    cidr_list   = ["0.0.0.0/0", "::/0"]
  }

  ingress {
    description = "NodePort services"
    protocol    = "TCP"
    cidr_list   = ["0.0.0.0/0", "::/0"]
    ports       = ["30000-32767"]
  }
}

resource "exoscale_sks_cluster" "cluster" {
  zone          = "at-vie-1"
  name          = "dev-sks"
  service_level = "starter"
  version       = "1.25.1"
  depends_on    = [exoscale_security_group.sks]
  auto_upgrade  = false
}

resource "exoscale_sks_nodepool" "nodepool" {
  zone               = "at-vie-1"
  cluster_id         = exoscale_sks_cluster.cluster.id
  name               = "dev-sks-nodepool"
  instance_type      = "standard.medium"
  instance_prefix    = "default-medium"
  size               = 1
  disk_size          = 50
  security_group_ids = [exoscale_security_group.sks.id]
}