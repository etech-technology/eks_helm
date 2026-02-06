# Instructor Runbook (Exact Steps)

This is the same flow as `scripts/demo_runbook.sh`, but with talk-track hints.

## 1) Setup
```bash
kubectl create ns demo || true
kubectl -n demo get all
```

## 2) Install public chart (Bitnami NGINX)
```bash
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

helm install web bitnami/nginx -n demo
kubectl -n demo get deploy,po,svc
```

Access it:
```bash
kubectl -n demo port-forward svc/web-nginx 8080:80
# open http://localhost:8080
```

## 3) Upgrade + rollback
```bash
helm upgrade web bitnami/nginx -n demo --set replicaCount=2
helm history web -n demo
helm rollback web 1 -n demo
```

## 4) Teach chart anatomy (your own chart)
Render first (no deploy):
```bash
helm template demo-hello ./charts/hello -n demo | head -n 60
```

Install:
```bash
helm install demo-hello ./charts/hello -n demo
kubectl -n demo get deploy,po,svc
```

Access:
```bash
kubectl -n demo port-forward svc/demo-hello-hello 8081:80
# open http://localhost:8081
```

Upgrade (replicas + message):
```bash
helm upgrade demo-hello ./charts/hello -n demo   --set replicaCount=2   --set env[0].value="Updated via helm upgrade!"
```

## 5) Optional: EKS external LB
```bash
helm upgrade demo-hello ./charts/hello -n demo --set service.type=LoadBalancer
kubectl -n demo get svc -w
```

## 6) Cleanup
```bash
helm uninstall web -n demo || true
helm uninstall demo-hello -n demo || true
kubectl delete ns demo || true
```
