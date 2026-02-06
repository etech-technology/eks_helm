#!/usr/bin/env bash
set -euo pipefail

NAMESPACE="demo"

echo "==> Pre-checks"
kubectl get nodes >/dev/null
helm version >/dev/null
kubectl create ns "$NAMESPACE" 2>/dev/null || true

echo "==> 1) Install Bitnami NGINX (public chart)"
helm repo add bitnami https://charts.bitnami.com/bitnami 2>/dev/null || true
helm repo update >/dev/null

helm install web bitnami/nginx -n "$NAMESPACE" 2>/dev/null || true
kubectl -n "$NAMESPACE" get deploy,po,svc

echo
echo "TIP: In another terminal, run:"
echo "  kubectl -n $NAMESPACE port-forward svc/web-nginx 8080:80"
echo "Then open http://localhost:8080"
echo

echo "==> 2) Upgrade NGINX replicas"
helm upgrade web bitnami/nginx -n "$NAMESPACE" --set replicaCount=2
helm history web -n "$NAMESPACE" | head -n 20

echo "==> 3) Rollback to revision 1"
helm rollback web 1 -n "$NAMESPACE"
kubectl -n "$NAMESPACE" get pods

echo "==> 4) Teach custom chart: render -> install -> port-forward"
echo "-- Render (no deploy):"
helm template demo-hello ./charts/hello -n "$NAMESPACE" | head -n 60

helm install demo-hello ./charts/hello -n "$NAMESPACE" 2>/dev/null || true
kubectl -n "$NAMESPACE" get deploy,po,svc

echo
echo "TIP: In another terminal, run:"
echo "  kubectl -n $NAMESPACE port-forward svc/demo-hello-hello 8081:80"
echo "Then open http://localhost:8081"
echo

echo "==> 5) Upgrade custom chart (replicas + message)"
helm upgrade demo-hello ./charts/hello -n "$NAMESPACE"   --set replicaCount=2   --set env[0].value="Updated via helm upgrade!"

kubectl -n "$NAMESPACE" get pods -l app.kubernetes.io/instance=demo-hello

echo
echo "OPTIONAL (EKS external access):"
echo "  helm upgrade demo-hello ./charts/hello -n $NAMESPACE --set service.type=LoadBalancer"
echo "  kubectl -n $NAMESPACE get svc -w"
echo "REMEMBER: clean up the LoadBalancer after the demo."
