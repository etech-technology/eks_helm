#!/usr/bin/env bash
set -euo pipefail

NAMESPACE="${1:-demo}"

echo "==> Uninstalling Helm releases (if present)"
helm uninstall web -n "$NAMESPACE" 2>/dev/null || true
helm uninstall demo-hello -n "$NAMESPACE" 2>/dev/null || true

echo "==> Deleting namespace '$NAMESPACE'"
kubectl delete ns "$NAMESPACE" 2>/dev/null || true

echo "Cleanup complete."
