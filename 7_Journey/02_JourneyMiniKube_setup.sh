#!/bin/bash

# Start Minikube
minikube start

cd /workspaces/PrometheusThanosConnection/5_Symbols/SymbolsMinikube
# Apply Kubernetes configurations
kubectl apply -f prometheus-config.yaml
kubectl apply -f prometheus-deployment.yaml
kubectl apply -f prometheus-service.yaml
kubectl apply -f thanos-sidecar-deployment.yaml
kubectl apply -f thanos-sidecar-service.yaml
kubectl apply -f thanos-query-deployment.yaml
kubectl apply -f thanos-query-service.yaml

# Wait for pods to be ready
echo "Waiting for pods to be ready..."
kubectl wait --for=condition=Ready pod -l app=prometheus --timeout=120s
kubectl wait --for=condition=Ready pod -l app=thanos-sidecar --timeout=120s
kubectl wait --for=condition=Ready pod -l app=thanos-query --timeout=120s

# Port forward Prometheus and Thanos Query
kubectl port-forward svc/prometheus 9090:9090 &
kubectl port-forward svc/thanos-query 10902:9091 &

echo "Setup complete. Prometheus is available at http://localhost:9090"
echo "Thanos Query is available at http://localhost:10902"
