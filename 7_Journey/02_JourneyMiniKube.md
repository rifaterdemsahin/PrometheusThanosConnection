# Setting Up Thanos with Prometheus

This guide will help you set up Thanos to connect directly to Prometheus for querying metrics.

## Prerequisites

- Docker installed on your machine
- Prometheus instance running

## Steps

1. **Create a Docker Network**

    ```sh
    docker network create thanos-network
    ```

2. **Run Prometheus**

    Create a `prometheus.yml` configuration file:

    ```yaml
    global:
      scrape_interval: '15s'

    scrape_configs:
      - job_name: 'prometheus'
         static_configs:
            - targets: ['localhost:9090']
    ```

    Run Prometheus container:

    ```sh
    docker run -d --name prometheus --network thanos-network -p 9090:9090 -v $(pwd)/prometheus.yml:/etc/prometheus/prometheus.yml prom/prometheus
    ```

3. **Run Thanos Sidecar**

    ```sh
    docker run -d --name thanos-sidecar --network thanos-network \
      -v $(pwd)/prometheus:/prometheus \
      -v $(pwd)/thanos:/thanos \
      quay.io/thanos/thanos:latest \
      sidecar --tsdb.path /prometheus --prometheus.url http://prometheus:9090
    ```

4. **Run Thanos Query**

    ```sh
    docker run -d --name thanos-query --network thanos-network -p 10902:10902 \
      quay.io/thanos/thanos:latest \
      query --http-address 0.0.0.0:10902 --store sdnsrv+_grpc._tcp.thanos-sidecar
    ```

5. **Access Thanos Query UI**

    Open your browser and go to `http://localhost:10902` to access the Thanos Query UI.

## Conclusion

You have successfully set up Thanos to connect directly to Prometheus for querying metrics. You can now use the Thanos Query UI to explore your metrics.
