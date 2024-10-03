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


@rifaterdemsahin ➜ /workspaces/PrometheusThanosConnection (main) $ docker network inspect code_default
[
    {
        "Name": "code_default",
        "Id": "3c47ae23d910e64cd6931c3ae01cdecc0c26e3cb30d5fb4deee8a964f1ab13c0",
        "Created": "2024-10-03T13:30:22.267494161Z",
        "Scope": "local",
        "Driver": "bridge",
        "EnableIPv6": false,
        "IPAM": {
            "Driver": "default",
            "Options": null,
            "Config": [
                {
                    "Subnet": "172.18.0.0/16",
                    "Gateway": "172.18.0.1"
                }
            ]
        },
        "Internal": false,
        "Attachable": false,
        "Ingress": false,
        "ConfigFrom": {
            "Network": ""
        },
        "ConfigOnly": false,
        "Containers": {
            "ad56e288b65ec1414893c6d542a93caff9b950162d5d42116b04f8b56e297ddd": {
                "Name": "code-prometheus-1",
                "EndpointID": "8f8279e484ab2b2f2eda3454b203b2f399861386190bd90371f8f88cc9b19585",
                "MacAddress": "02:42:ac:12:00:02",
                "IPv4Address": "172.18.0.2/16",
                "IPv6Address": ""
            },
            "f894b56e05cd760612180096b3985308923c377a17a5e3e1182f2c226188dfdd": {
                "Name": "code-busybox-1",
                "EndpointID": "aea595387461b72d2bc4513935772a17e318fde0147f8f0300be85351e251289",
                "MacAddress": "02:42:ac:12:00:04",
                "IPv4Address": "172.18.0.4/16",
                "IPv6Address": ""
            },
            "f92b5de319bd7726be396ceb20a021d588852ec310406db5b4807ec63f291623": {
                "Name": "code-thanos-query-1",
                "EndpointID": "22bbd8027947c13e2d7bb0c46eeeca6a16dc0960563d5649150ea32ad4b4c69a",
                "MacAddress": "02:42:ac:12:00:03",
                "IPv4Address": "172.18.0.3/16",
                "IPv6Address": ""
            }
        },
        "Options": {},
        "Labels": {
            "com.docker.compose.network": "default",
            "com.docker.compose.project": "code",
            "com.docker.compose.version": "2.29.7"
        }
    }
]
@rifaterdemsahin ➜ /workspaces/PrometheusThanosConnection (main) $ ^C
@rifaterdemsahin ➜ /workspaces/PrometheusThanosConnection (main) $ 


Updated to >>
version: '3.7'

services:
  prometheus:
    image: prom/prometheus:latest
    volumes:
      - ./prometheus-remotewrite-loaded.yml:/etc/prometheus/prometheus-remotewrite-loaded.yml
    ports:
      - "9090:9090"
    networks:
      - code_default

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
      - code_default

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
      - code_default

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
      - code_default

  busybox:
    image: busybox
    command: sh -c "while true; do echo 'Generating load'; sleep 1; done"
    networks:
      - code_default

networks:
  code_default:
    external: true
