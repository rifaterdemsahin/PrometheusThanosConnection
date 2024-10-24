#!/bin/bash

# Start Minikube
minikube start

cd /workspaces/PrometheusThanosConnection/5_Symbols/SymbolsMinikube

# Create the monitoring namespace
kubectl create namespace monitoring

# Apply Kubernetes configurations in the monitoring namespace
kubectl apply -f prometheus-config.yaml -n monitoring
kubectl apply -f prometheus-deployment.yaml -n monitoring
kubectl apply -f prometheus-service.yaml -n monitoring
kubectl apply -f thanos-sidecar-deployment.yaml -n monitoring
kubectl apply -f thanos-sidecar-service.yaml -n monitoring
kubectl apply -f thanos-query-deployment.yaml -n monitoring
kubectl apply -f thanos-query-service.yaml -n monitoring

# Wait for pods to be ready in the monitoring namespace
echo "Waiting for pods to be ready..."
kubectl wait --for=condition=Ready pod -l app=prometheus -n monitoring --timeout=120s
kubectl wait --for=condition=Ready pod -l app=thanos-sidecar -n monitoring --timeout=120s
kubectl wait --for=condition=Ready pod -l app=thanos-query -n monitoring --timeout=120s

# Port forward Prometheus and Thanos Query in the monitoring namespace
kubectl port-forward svc/prometheus -n monitoring 9090:9090 &
kubectl port-forward svc/thanos-query -n monitoring 10902:9091 &

echo "Setup complete. Prometheus is available at http://localhost:9090"
echo "Thanos Query is available at http://localhost:10902"


# git pull; git add . && git commit -m "Refine task priorities in copilot" && git push;clear.exe git pull; git add . && git commit -m "Refine task priorities in copilot" && git push;clear.exe 