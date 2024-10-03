docker logs -f code-thanos-query-1

![alt text](/Resources/thanos-query-logs.png)

@rifaterdemsahin ➜ /workspaces/PrometheusThanosConnection (main) $ docker network ls
NETWORK ID     NAME           DRIVER    SCOPE
cdf7248109c9   bridge         bridge    local
dab80e88fab5   code_default   bridge    local
c5bdc3c8006b   host           host      local
745a1aa24687   none           null      local
@rifaterdemsahin ➜ /workspaces/PrometheusThanosConnection (main) $ 


It looks like your services are connected to the `code_default` network. Let's ensure that all your Thanos services are correctly using this network and that the service names are properly referenced.

### Verify and Update Docker Compose Configuration
Ensure that your `docker-compose.yml` file specifies the correct network and that all services are using it.

### Updated `docker-compose.yml`
```yaml
version: '3.7'

networks:
  default:
    name: code_default

services:
  prometheus:
    image: prom/prometheus:latest
    volumes:
      - ./prometheus-remotewrite-loaded.yml:/etc/prometheus/prometheus-remotewrite-loaded.yml
    ports:
      - "9090:9090"
    networks:
      - default

  thanos-sidecar:
    image: quay.io/thanos/thanos:v0.35.1
    command:
      - sidecar
      - --tsdb.path=/var/prometheus
      - --prometheus.url=http://prometheus:9090
      - --grpc-address=0.0.0.0:10921
      - --http-address=0.0.0.0:10922
    volumes:
      - ./prometheus-data:/var/prometheus
    depends_on:
      - prometheus
    ports:
      - "10921:10921"
      - "10922:10922"
    networks:
      - default

  thanos-query:
    image: quay.io/thanos/thanos:v0.35.1
    command:
      - query
      - --http-address=0.0.0.0:9091
      - --store=thanos-sidecar:10921
      - --store=thanos-receive:10921
    depends_on:
      - thanos-sidecar
      - thanos-receive
    ports:
      - "9091:9091"
    networks:
      - default

  thanos-receive:
    image: quay.io/thanos/thanos:v0.35.1
    command:
      - receive
      - --http-address=0.0.0.0:10902
      - --grpc-address=0.0.0.0:10921
      - --remote-write.address=0.0.0.0:19291
    ports:
      - "10921:10921"
      - "10902:10902"
      - "19291:19291"
    networks:
      - default

  busybox:
    image: busybox
    command: sh -c "while true; do echo 'Generating load'; sleep 1; done"
    networks:
      - default
```

### Restart Docker Compose
1. **Bring Down Existing Services**:
   ```sh
   docker-compose -f /workspaces/PrometheusThanosConnection/Code/docker-compose-remotewrite-loaded.yaml down
   ```

2. **Bring Up Services with Updated Configuration**:
   ```sh
   docker-compose -f /workspaces/PrometheusThanosConnection/Code/docker-compose-remotewrite-loaded.yaml up
   ```

### Verify DNS Resolution
After restarting the services, verify that the DNS resolution works correctly by checking the logs again:
```sh
docker logs -f code-thanos-query-1
```

This should ensure that all services are correctly connected to the `code_default` network and can resolve each other's hostnames. If you encounter any further issues, feel free to ask!