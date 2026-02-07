# Helm Basics 

## Vocabulary
- **Chart**: a package (templates + defaults)
- **Release**: an installed instance of a chart (tracked with history)

## Core commands
```bash
helm repo add <name> <url>
helm repo update
helm search repo nginx

helm install <release> <chart> -n demo
helm upgrade <release> <chart> -n demo -f values.yaml --set key=value
helm status <release> -n demo
helm history <release> -n demo
helm rollback <release> <revision> -n demo
helm uninstall <release> -n demo
```

## Debug commands
```bash
helm template <release> <chart> -n demo
helm get manifest <release> -n demo
kubectl -n demo describe pod <pod>
kubectl -n demo logs <pod>
```

## point of focus
Helm is not “magic deployment”—Helm **renders YAML** from templates + values, then applies it.
