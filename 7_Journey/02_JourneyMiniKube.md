# Setting Up Thanos with Prometheus in Minikube

This guide will help you set up Thanos to connect directly to Prometheus for querying metrics using Minikube.

## Prerequisites

- Minikube installed on your machine
- kubectl installed on your machine
- Docker installed on your machine (for building images if needed)

## Setup Instructions

Swap back to codespaces

1. Start Minikube:   
```sh
   minikube start   
```

chmod 777 /workspaces/PrometheusThanosConnection/7_Journey/02_JourneyMiniKube_setup.sh
cd /workspaces/PrometheusThanosConnection/5_Symbols/SymbolsMinikube

```sh
# Delete the problematic pods
kubectl delete pod thanos-query-5df49cc4c4-wmxqb
kubectl delete pod thanos-sidecar-7f9bb547b-kcwbj
kubectl delete pod thanos-sidecar-68996566c8-swq67
```

2. Apply the Kubernetes configurations:   ```sh
   kubectl apply -n monitoring -f prometheus-config.yaml
   kubectl apply -n monitoring -f prometheus-deployment.yaml
   kubectl apply -n monitoring -f prometheus-service.yaml
   kubectl apply -n monitoring -f thanos-sidecar-deployment.yaml
   kubectl apply -n monitoring -f thanos-sidecar-service.yaml
   kubectl apply -n monitoring -f thanos-query-deployment.yaml
   kubectl apply -n monitoring -f thanos-query-service.yaml

   ```sh
   # Delete the applied Kubernetes configurations
   kubectl delete -n monitoring -f prometheus-config.yaml
   kubectl delete -n monitoring -f prometheus-deployment.yaml
   kubectl delete -n monitoring -f prometheus-service.yaml
   kubectl delete -n monitoring -f thanos-sidecar-deployment.yaml
   kubectl delete -n monitoring -f thanos-sidecar-service.yaml
   kubectl delete -n monitoring -f thanos-query-deployment.yaml
   kubectl delete -n monitoring -f thanos-query-service.yaml
  
     # Delete the applied Kubernetes configurations
   kubectl delete -n default -f prometheus-config.yaml
   kubectl delete -n default -f prometheus-deployment.yaml
   kubectl delete -n default -f prometheus-service.yaml
   kubectl delete -n default -f thanos-sidecar-deployment.yaml
   kubectl delete -n default -f thanos-sidecar-service.yaml
   kubectl delete -n default -f thanos-query-deployment.yaml
   kubectl delete -n default -f thanos-query-service.yaml
  
  
   ```

   kubectl get pods -A


3. Wait for the pods to be ready:   ```sh
   kubectl wait --for=condition=Ready pod -l app=prometheus --timeout=120s
   kubectl wait --for=condition=Ready pod -l app=thanos-sidecar --timeout=120s
   kubectl wait --for=condition=Ready pod -l app=thanos-query --timeout=120s   ```

4. Port forward Prometheus and Thanos Query:   ```sh
   kubectl port-forward svc/prometheus 9090:9090 &
   kubectl port-forward svc/thanos-query 10902:9091 &   ```

5. Access the UIs:
   - Prometheus UI: http://localhost:9090
   - Thanos Query UI: http://localhost:10902

## Cleaning Up

To stop the port forwarding and delete the Kubernetes resources:

1. Stop the port forwarding processes (usually by pressing Ctrl+C in the terminal where you ran them).

2. Delete the Kubernetes resources:   ```sh
   kubectl delete -f .   ```

3. Stop Minikube:   ```sh
   minikube stop   ```

## Troubleshooting

If you encounter any issues, you can check the status of the pods:
