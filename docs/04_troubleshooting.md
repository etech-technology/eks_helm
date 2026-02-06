# Troubleshooting Cheatsheet

## Helm install/upgrade fails
- Render locally:
  ```bash
  helm template demo-hello ./charts/hello -n demo
  ```
- See what actually applied:
  ```bash
  helm get manifest demo-hello -n demo
  ```

## Pod stuck Pending
- Check events:
  ```bash
  kubectl -n demo describe pod <pod>
  kubectl -n demo get events --sort-by=.lastTimestamp | tail
  ```
Common causes:
- no nodes/insufficient resources
- image pull issues
- missing permissions (rare for this demo)

## Service LoadBalancer not getting external address (EKS)
- Wait 1–5 minutes.
- Ensure cluster has proper AWS cloud integration (EKS does).
- Check service events:
  ```bash
  kubectl -n demo describe svc demo-hello-hello
  ```

## Port-forward connection refused
- Ensure pod is ready:
  ```bash
  kubectl -n demo get pods
  ```
- Verify service exists and ports match:
  ```bash
  kubectl -n demo get svc -o wide
  ```
