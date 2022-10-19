# ArgoCD

## Setup

Install ArgoCD

```bash
$ kubectl create namespace argocd
$ kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

Tunnel to the server:

```bash
$ kubectl -n argocd port-forward svc/argocd-server -n argocd 8083:80
```

Open https://localhost:8083

Login using `admin` and the argocd password. To get the password:

```bash
$ kubectl -n argocd get secrets argocd-initial-admin-secret -o json
```

One needs to decode the password from base64.

## Apps

Apps are within [/apps](/apps) folder.

Use `kubectl` to create apps:

```bash
$ kubectl apply -f apps/*
```