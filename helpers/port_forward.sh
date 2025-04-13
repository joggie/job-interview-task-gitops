#!/bin/bash

echo "Starting port-forward"
kubectl -n argocd port-forward svc/argocd-server 8083:80 > /dev/null 2>&1 &
PF_PID=$!

echo $PF_PID