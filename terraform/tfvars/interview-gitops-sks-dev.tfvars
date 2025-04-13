# a config of a possible dev cluster

zone         = "at-vie-1"
cluster_name = "interview-gitops-sks-dev"
cluster_cni  = "calico"

nodepool_name          = "interview-gitops-sks-dev-nodepool"
nodepool_size          = 1
nodepool_disk_size     = 20
nodepool_instance_type = "standard.tiny"