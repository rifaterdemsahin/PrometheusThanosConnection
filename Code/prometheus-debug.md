It looks like Prometheus is not running even though the container was started. Here are a few steps to troubleshoot and resolve the issue:

### 1. Check Prometheus Logs
First, check the logs of the Prometheus container to see if there are any errors or issues preventing it from running properly.

```bash
docker logs code-prometheus-1
```

### 2. Verify Prometheus Configuration
Ensure that the `prometheus.yml` configuration file is correctly formatted and accessible. Here is the configuration you provided:

```yaml
global:
  scrape_interval: 15s

scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['localhost:9090']
  remote_write:
    - url: "http://thanos-sidecar:10901/api/v1/receive"
```

### 3. Check Volume Mounts
Ensure that the volume mount for the Prometheus configuration file is correct. The `docker-compose.yml` should correctly map the configuration file:

```yaml
services:
  prometheus:
    image: prom/prometheus:latest
    volumes:
      - ./prometheus.yml:/etc/prometheus/prometheus.yml
    ports:
      - "9090:9090"
```

### 4. Inspect Container Status
Check the status of the Prometheus container to see if it is restarting or exiting immediately after starting. This can be done using:

```bash
docker ps -a
```

### 5. Validate Docker Compose File
Ensure that the Docker Compose file does not have any syntax errors or deprecated attributes. The warning about the `version` attribute being obsolete can be ignored, but it's good practice to remove it to avoid confusion.

### 6. Restart the Services
Sometimes, simply restarting the services can resolve transient issues:

```bash
docker-compose -f /workspaces/PrometheusThanosConnection/Code/docker-compose-remotewrite.yaml down
docker-compose -f /workspaces/PrometheusThanosConnection/Code/docker-compose-remotewrite.yaml up -d
```

By following these steps, you should be able to identify and resolve the issue preventing Prometheus from running. If you encounter specific errors in the logs, feel free to share them, and I can help you troubleshoot further! 🚀