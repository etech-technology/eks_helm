# 2-Hour Agenda (Beginner Helm on EKS)

## 0:00–0:05  Pre-demo checks
- `kubectl get nodes`
- `helm version`
- create namespace: `demo`

## 0:05–0:15  Kubernetes in 10 minutes
- Pod (runs containers)
- Deployment (keeps N pods running)
- Service (stable DNS + load-balancing to pods)
- Namespace (folder/space for resources)

## 0:15–0:25  Helm in 10 minutes
- Chart = templates + default values
- Release = installed chart instance
- Helm renders YAML then applies it to Kubernetes

## 0:25–0:45  Install a public chart (Bitnami NGINX)
- `helm repo add`, `helm install`
- inspect resources
- access via `kubectl port-forward`

## 0:45–0:55  Upgrade + rollback
- change `replicaCount`
- `helm history`, `helm rollback`

## 0:55–1:35  Build your own chart (hello)
- chart anatomy: `Chart.yaml`, `values.yaml`, `templates/`
- show `helm template`
- `helm install demo-hello ./charts/hello`
- upgrade values live (`replicaCount`, message text)

## 1:35–1:55  Optional EKS moment: External access
- `helm upgrade ... --set service.type=LoadBalancer`
- show `kubectl get svc -w`
- emphasize AWS cost + cleanup

## 1:55–2:00  Cleanup + recap
- uninstall releases
- delete namespace
- recap key commands
