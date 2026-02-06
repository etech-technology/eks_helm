# Python Single-Page App (FastAPI) + Postgres deployed with Helm (EKS-ready)

This repo gives you a minimal **single-page** web app:
- FastAPI serves `/` (HTML) + `/static/*` (JS/CSS)
- API endpoints read/write notes in Postgres (`/api/notes`)
- Helm chart deploys:
  - the app Deployment/Service
  - **Bitnami PostgreSQL** as a dependency

## 1) Build & push image
Build locally:
```bash
docker build -t <your-repo>/pyspa:0.1.0 .
```

Push to a registry (ECR/DockerHub) and update Helm `chart/pyspa/values.yaml` under `image.repository` and `image.tag`.

## 2) Deploy with Helm
```bash
cd chart/pyspa
helm dependency update
helm upgrade --install pyspa . -n demo --create-namespace
```

Port-forward:
```bash
kubectl -n demo port-forward svc/pyspa 8080:80
# open http://localhost:8080
```

## 3) Cleanup
```bash
helm uninstall pyspa -n demo
```
