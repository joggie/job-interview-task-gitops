#!/bin/bash

KUBECONFIG="${HOME}/.kube/env/interview-gitops-sks.kubeconfig"

echo "Adding Helm repo"
helm repo add argo https://argoproj.github.io/argo-helm
helm repo update

echo "Installing Argo CD"
helm upgrade --install argocd argo/argo-cd \
  --version 7.8.24 \
  --namespace argocd \
  --create-namespace \
  -f ./argocd/clusters/interview-gitops-sks/applications/argocd/helm-values.yaml

kustomize build ./argocd/bootstrap/overlays/interview-gitops-sks | kubectl apply -f -

kustomize build ./argocd/components/appprojects | kubectl apply -f -

echo "Waiting for Argo CD admin password to become available..."
for i in {1..30}; do
  if kubectl -n argocd get secret argocd-initial-admin-secret &>/dev/null; then
    ARGOCD_ADMIN_PASSWORD=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)
    printf "Admin password: \033[31m%s\033[0m\n" "$ARGOCD_ADMIN_PASSWORD"
    break
  fi
  echo "Waiting for secret... retry $i"
  sleep 5
done