#!/usr/bin/env bash
set -euo pipefail

NAMESPACE="${1:-demo}"

kubectl create ns "$NAMESPACE" 2>/dev/null || true
echo "Namespace '$NAMESPACE' is ready."
kubectl -n "$NAMESPACE" get all || true
