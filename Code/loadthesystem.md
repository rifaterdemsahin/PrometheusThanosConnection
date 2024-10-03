To add a container that generates data and sends it to Prometheus, you can include a simple container that simulates load or metrics. Here's an updated version of your `docker-compose.yml` file with an additional service for a busybox container that generates CPU load:

```yaml
version: '3.7'

services:
  prometheus:
    image: prom/prometheus:latest
    volumes:
      - ./prometheus.yml:/etc/prometheus/prometheus.yml
    ports:
      - "9090:9090"

  thanos-sidecar:
    image: quay.io/thanos/thanos:v0.35.1
    command:
      - sidecar
      - --tsdb.path=/var/prometheus
      - --prometheus.url=http://prometheus:9090
      - --grpc-address=0.0.0.0:10901
      - --http-address=0.0.0.0:10902
    volumes:
      - ./prometheus-data:/var/prometheus
    depends_on:
      - prometheus
    ports:
      - "10901:10901"
      - "10902:10902"

  thanos-query:
    image: quay.io/thanos/thanos:v0.35.1
    command:
      - query
      - --http-address=0.0.0.0:9091
      - --store=thanos-sidecar:10901
    depends_on:
      - thanos-sidecar
    ports:
      - "9091:9091"

  busybox:
    image: busybox
    command: sh -c "while true; do echo 'Generating load'; sleep 1; done"
```

### Prometheus Configuration
Ensure your `prometheus.yml` file is set up to scrape the metrics from the busybox container and to use remote write to Thanos:

```yaml
global:
  scrape_interval: 15s

scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['localhost:9090']

  - job_name: 'busybox'
    static_configs:
      - targets: ['busybox:9090']

remote_write:
  - url: "http://thanos-sidecar:10901/api/v1/receive"
```

### Explanation
- **Busybox Service**: This service runs a simple loop that generates load. You can replace this with any other container that generates metrics.
- **Prometheus Configuration**: The `scrape_configs` section includes a job to scrape metrics from the busybox container. The `remote_write` section ensures that Prometheus sends the metrics to Thanos.

This setup should help you generate data, scrape it with Prometheus, and push it to Thanos using remote write. If you have any specific metrics or further questions, feel free to ask!