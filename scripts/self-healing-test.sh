#!/usr/bin/env bash

set -euo pipefail

# Deletes one nginx pod and verifies the Deployment recreates it.
APP_LABEL="app=nginx"
DEPLOYMENT="nginx"

pod=$(kubectl get pods -l "$APP_LABEL" -o jsonpath='{.items[0].metadata.name}')
echo "Deleting pod: $pod"
kubectl delete pod "$pod" --wait=false

kubectl rollout status deployment/"$DEPLOYMENT" --timeout=120s
kubectl get pods -l "$APP_LABEL"

if kubectl get pod "$pod" >/dev/null 2>&1; then
  echo "FAIL: original pod still exists" >&2
  exit 1
fi
echo "PASS: pod was replaced and deployment is healthy"
