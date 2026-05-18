#!/usr/bin/env bash
set -euo pipefail

SA=gitea-deployer
NAMESPACE=gitea
SECRET=gitea-deployer-token
OUT=/tmp/gitea-deployer.kubeconfig

# Apply RBAC if not already present
kubectl apply -f "$(dirname "$0")/deployer-rbac.yaml"

# Wait for token to be populated
echo "Waiting for token secret..."
until kubectl get secret $SECRET -n $NAMESPACE -o jsonpath='{.data.token}' 2>/dev/null | grep -q .; do
  sleep 1
done

TOKEN=$(kubectl get secret $SECRET -n $NAMESPACE -o jsonpath='{.data.token}' | base64 -d)
CA=$(kubectl get secret $SECRET -n $NAMESPACE -o jsonpath='{.data.ca\.crt}')

kubectl --kubeconfig=$OUT config set-cluster in-cluster \
  --server=https://kubernetes.default.svc \
  --certificate-authority=<(echo "$CA" | base64 -d) \
  --embed-certs=true

kubectl --kubeconfig=$OUT config set-credentials $SA --token=$TOKEN

kubectl --kubeconfig=$OUT config set-context default \
  --cluster=in-cluster --user=$SA

kubectl --kubeconfig=$OUT config use-context default

echo ""
echo "=== Gitea secret KUBE_CONFIG ==="
base64 -w0 $OUT
echo ""
