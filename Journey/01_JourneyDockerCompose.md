# Setting Up Thanos with Prometheus Docker

This guide will help you set up Thanos to connect directly to Prometheus for querying metrics on Docker.

## Prerequisites

- Docker installed on your machine

## Steps

1. **Start Docker**

  Ensure Docker is running on your machine.
  
  ```sh
  docker info
  ```

2. **Create Docker Compose File**

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

3. **Start Services with Docker Compose**

  ```sh
  docker-compose -f /workspaces/PrometheusThanosConnection/SymbolsCode/Docker/docker-compose.yml up -d
  ```

4. **Access Thanos Query UI**

  Open your browser and go to `http://localhost:10902` to access the Thanos Query UI.

## Conclusion

You have successfully set up Thanos to connect directly to Prometheus for querying metrics on Docker. You can now use the Thanos Query UI to explore your metrics.

