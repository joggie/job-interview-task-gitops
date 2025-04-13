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