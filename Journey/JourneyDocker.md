# Setting Up Thanos with Prometheus

This guide will help you set up Thanos to connect directly to Prometheus for querying metrics on Minikube.

## Prerequisites

- Minikube installed on your machine
- kubectl installed and configured
- Prometheus and Thanos Helm charts

## Steps

1. **Start Minikube**

    ```sh
    minikube start
    ```

2. **Add Helm Repositories**

    ```sh
    helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
    helm repo add bitnami https://charts.bitnami.com/bitnami
    helm repo update
    ```

3. **Install Prometheus**

    ```sh
    helm install prometheus prometheus-community/prometheus
    ```

4. **Install Thanos**

    ```sh
    helm install thanos bitnami/thanos
    ```

5. **Configure Thanos Sidecar**

    Edit the Prometheus deployment to include the Thanos sidecar:

    ```yaml
    extraContainers:
      - name: thanos-sidecar
        image: quay.io/thanos/thanos:latest
        args:
          - sidecar
          - --tsdb.path=/data
          - --prometheus.url=http://localhost:9090
        ports:
          - name: grpc
            containerPort: 10901
        volumeMounts:
          - name: storage-volume
            mountPath: /data
    ```

6. **Expose Thanos Query**

    ```sh
    kubectl port-forward svc/thanos-query 10902:10902
    ```

7. **Access Thanos Query UI**

    Open your browser and go to `http://localhost:10902` to access the Thanos Query UI.

## Conclusion

You have successfully set up Thanos to connect directly to Prometheus for querying metrics on Minikube. You can now use the Thanos Query UI to explore your metrics.

