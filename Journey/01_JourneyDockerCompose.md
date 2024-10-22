# Setting Up Thanos with Prometheus Docker

This guide will help you set up Thanos to connect directly to Prometheus for querying metrics on Docker.

## Prerequisites

- Prometheus and Thanos Helm charts

## Steps

1. **Start Docker**

  Ensure Docker is running on your machine.
  
```
  docker info
```

2. **Add Helm Repositories**

  ```sh
  helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
  helm repo add bitnami https://charts.bitnami.com/bitnami
  helm repo update
  ```

3. **Install Prometheus** 22 10 2024

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

6. **Create Docker Compose File**

  Create a `docker-compose.yml` file with the following content:

  ```yaml
  version: '3.7'

  services:
    prometheus:
      image: prom/prometheus:latest
      ports:
        - "9090:9090"
      volumes:
        - ./prometheus.yml:/etc/prometheus/prometheus.yml

    thanos-sidecar:
      image: quay.io/thanos/thanos:latest
      command:
        - sidecar
        - --tsdb.path=/data
        - --prometheus.url=http://prometheus:9090
      ports:
        - "10901:10901"
      volumes:
        - storage-volume:/data

    thanos-query:
      image: quay.io/thanos/thanos:latest
      command:
        - query
        - --store=thanos-sidecar:10901
      ports:
        - "10902:10902"

  volumes:
    storage-volume:
  ```

7. **Start Services with Docker Compose**

  ```sh
  docker-compose up -d
  ```

8. **Access Thanos Query UI**

  Open your browser and go to `http://localhost:10902` to access the Thanos Query UI.

## Conclusion

You have successfully set up Thanos to connect directly to Prometheus for querying metrics on Docker. You can now use the Thanos Query UI to explore your metrics.

