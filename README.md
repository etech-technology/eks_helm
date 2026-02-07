# EKS HelmCharts  Demo (Beginner-Friendly)

This repo is a **ready-to-run live demo** for students who are **new to Kubernetes** and need to learn **Helm charts on an EKS cluster**.

You will:
- explain Kubernetes basics (Pods / Deployments / Services / Namespaces)
- install a public Helm chart (Bitnami NGINX)
- upgrade + rollback a Helm release
- create and deploy a **minimal custom Helm chart** (`charts/hello`)
- (optional) expose it externally on EKS using `Service.type=LoadBalancer`

> Cost note: `Service.type=LoadBalancer` creates an AWS load balancer and may incur charges. Clean up after the demo.

---

## Quick Start (Instructor)

### Prereqs
- `kubectl` configured for your EKS cluster (e.g., `kubectl get nodes` works)
- Helm v3 installed (`helm version`)
- Permissions to create resources in the cluster

### Run the demo (recommended)
```bash
bash scripts/demo_runbook.sh
```

### Cleanup
```bash
bash scripts/cleanup.sh
```

---

## Repo Layout
- `docs/` : lecture notes + minute-by-minute agenda + troubleshooting
- `charts/hello/` : minimal Helm chart you teach and deploy
- `scripts/` : runnable demo scripts (setup, runbook, cleanup)

---

## What students should learn
- Helm **chart** vs **release**
- `helm install`, `helm upgrade`, `helm rollback`, `helm uninstall`
- `helm template` to render YAML and debug before deploying
- How Kubernetes objects fit together (Deployment + Service)
- How to access apps via `kubectl port-forward` (and optionally via LB on EKS)

---

## License
MIT (see `LICENSE`).
