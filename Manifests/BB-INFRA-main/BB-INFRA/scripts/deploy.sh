#!/bin/bash
# Helper script for deploying to QA

set -e

ENV=${1:-qa}
SERVICE=${2:-all}

echo "🚀 Deploying to $ENV environment..."

if [ "$SERVICE" == "all" ]; then
  echo "📦 Deploying all services..."
  kubectl apply -f argocd/$ENV/root-app.yaml
else
  echo "📦 Deploying $SERVICE..."
  kubectl apply -f argocd/$ENV/${SERVICE}-app.yaml
fi

echo "✅ Deployment triggered. Check ArgoCD UI for status."
