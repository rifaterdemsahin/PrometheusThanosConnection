# Starting Thanos Sidecar in Docker Compose

To start the Thanos Sidecar in Docker Compose, use the following command:

```sh
thanos sidecar \
    --tsdb.path            /path/to/prometheus/data \
    --prometheus.url       http://<prometheus-ip>:<port> \
    --grpc-address         0.0.0.0:<grpc-port> \
    --http-address         0.0.0.0:<http-port>
```

Replace the placeholders with the appropriate values:
- `<prometheus-ip>`: The IP address of your Prometheus instance.
- `<port>`: The port on which Prometheus is running.
- `<grpc-port>`: The port for gRPC communication.
- `<http-port>`: The port for HTTP communication.

Make sure to adjust the paths and ports according to your setup.

bash: clear.exe: command not found
@rifaterdemsahin ➜ /workspaces/PrometheusThanosConnection (main) $ docker ps
CONTAINER ID   IMAGE                           COMMAND                  CREATED          STATUS          PORTS                                       NAMES
9bdb74175ee1   prom/prometheus:latest          "/bin/prometheus --c…"   11 minutes ago   Up 11 minutes   0.0.0.0:9090->9090/tcp, :::9090->9090/tcp   docker-prometheus-1
fe1a6d4d6325   quay.io/thanos/thanos:v0.35.1   "/bin/thanos query -…"   14 minutes ago   Up 11 minutes   0.0.0.0:9091->9091/tcp, :::9091->9091/tcp   docker-thanos-query-1
@rifaterdemsahin ➜ /workspaces/PrometheusThanosConnection (main) $ ^C

To verify that the Thanos Sidecar is running correctly, you can use the `docker ps` command to list all running containers. Look for the container running the Thanos Sidecar and ensure it is up and running.

```sh
docker ps
```

You should see an output similar to the following, indicating that the Thanos Sidecar is running:

```
CONTAINER ID   IMAGE                           COMMAND                  CREATED          STATUS          PORTS                                       NAMES
<container-id> quay.io/thanos/thanos:v0.35.1   "/bin/thanos sidecar…"   <time>           Up <time>       0.0.0.0:<grpc-port>-><grpc-port>/tcp, 0.0.0.0:<http-port>-><http-port>/tcp   <container-name>
```

Replace `<container-id>`, `<time>`, `<grpc-port>`, `<http-port>`, and `<container-name>` with the actual values from your setup.