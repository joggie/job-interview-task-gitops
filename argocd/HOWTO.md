# ArgoCD

## Setup

Install ArgoCD

```bash
kubectl create namespace argocd
```
```bash
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

## Using the Web-UI

1. Tunnel to the server:

```bash
kubectl -n argocd port-forward svc/argocd-server -n argocd 8083:80
```

2. Open https://localhost:8083

3. Login using `admin` and the argocd password.

Note: To get the password, use the following command and decode the password from `base64`:

```bash
kubectl -n argocd get secrets argocd-initial-admin-secret -o json
```

## Deploying the additional Apps

Apps are within the [/apps](/apps) folder.

Use `kubectl` to create apps:

```bash
kubectl apply -f apps/*
```