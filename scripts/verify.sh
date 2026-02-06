#!/usr/bin/env bash
set -euo pipefail

NAMESPACE="${1:-demo}"

echo "==> Cluster check"
kubectl get nodes
echo "==> Helm check"
helm version
echo "==> Namespace resources"
kubectl -n "$NAMESPACE" get all || true
