# Kubernetes Basics (Teaching Notes)

Use these analogies to keep it simple:

- **Pod**: a running unit that contains 1+ containers.
- **Deployment**: a controller that ensures a desired number of Pods exist.
- **Service**: stable name + virtual IP that load-balances traffic to Pods.
- **Namespace**: a logical folder to isolate resources.

## Demo commands
```bash
kubectl get nodes
kubectl get ns
kubectl -n demo get all
kubectl -n demo describe deploy <name>
kubectl -n demo logs <pod>
```

## Key teaching point
Kubernetes is **declarative**: you declare desired state, controllers reconcile actual state.
