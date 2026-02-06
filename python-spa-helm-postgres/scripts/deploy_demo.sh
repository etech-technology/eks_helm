#!/usr/bin/env bash
set -euo pipefail

NAMESPACE="${1:-demo}"
RELEASE="${2:-pyspa}"

echo "==> Update chart dependencies"
cd chart/pyspa
helm dependency update

echo "==> Deploy (app + postgres)"
helm upgrade --install "$RELEASE" . -n "$NAMESPACE" --create-namespace

echo "==> Show resources"
kubectl -n "$NAMESPACE" get pods,svc

echo
echo "Port-forward:"
echo "  kubectl -n $NAMESPACE port-forward svc/$RELEASE 8080:80"
echo "Open: http://localhost:8080"
