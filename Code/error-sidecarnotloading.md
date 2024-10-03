@rifaterdemsahin ➜ /workspaces/PrometheusThanosConnection (main) $ docker logs code-thanos-receive-1
ts=2024-10-03T13:46:47.248944118Z caller=main.go:77 level=debug msg="maxprocs: Leaving GOMAXPROCS=[2]: CPU quota undefined"
ts=2024-10-03T13:46:47.249778332Z caller=main.go:145 level=error err="no external labels configured for receive, uniquely identifying external labels must be configured (ideally with `receive_` prefix); see https://thanos.io/tip/thanos/storage.md#external-labels for details.\nmain.registerReceive.func1\n\t/app/cmd/thanos/receive.go:75\nmain.main\n\t/app/cmd/thanos/main.go:143\nruntime.main\n\t/usr/local/go/src/runtime/proc.go:267\nruntime.goexit\n\t/usr/local/go/src/runtime/asm_amd64.s:1650\npreparing receive command failed\nmain.main\n\t/app/cmd/thanos/main.go:145\nruntime.main\n\t/usr/local/go/src/runtime/proc.go:267\nruntime.goexit\n\t/usr/local/go/src/runtime/asm_amd64.s:1650"

--------------------------------------------------------



The error message indicates that the Thanos Receive component requires external labels to be configured. These labels uniquely identify the data blocks across Thanos clusters. Let's add the necessary external labels to your Thanos Receive configuration.

### Updated `docker-compose.yml` with External Labels
Here’s how you can update your `docker-compose.yml` file to include the required external labels:

```yaml
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
      - --log.level=debug
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
      - --log.level=debug
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
      - --log.level=debug
      - --label=receive_replica=<unique_replica_label>
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
```

### Explanation
- **External Labels**: The `--label=receive_replica=<unique_replica_label>` flag adds a unique label to the Thanos Receive component. Replace `<unique_replica_label>` with a unique identifier for your setup.

### Restart Docker Compose
1. **Bring Down Existing Services**:
   ```sh
   docker-compose -f /workspaces/PrometheusThanosConnection/Code/docker-compose-remotewrite-loaded.yaml down
   ```

2. **Bring Up Services with Updated Configuration**:
   ```sh
   docker-compose -f /workspaces/PrometheusThanosConnection/Code/docker-compose-remotewrite-loaded.yaml up
   ```

### Verify Logs
After restarting the services, check the logs for `thanos-receive` to ensure it starts correctly:
```sh
docker logs -f code-thanos-receive-1
```

This should resolve the issue with Thanos Receive not starting due to missing external labels. If you encounter any further issues or need additional assistance, feel free to ask!

---------------


@rifaterdemsahin ➜ /workspaces/PrometheusThanosConnection (main) $  ✔ Container code-thanos-query-1    Created                                                                                                                                                                           0.2s 
bash: ✔: command not found
iver failed programming external connectivity on endpoint code-thanos-sidecar-1 (48e16fba5219b405c9b20a87b006a23c87f6b1d39fe3b1127b9b16aef6ee59da): Bi@rifaterdemsahin ➜ /workspaces/PrometheusThanosConnection (main) $ Error response from daemon: driver failed programming external connectivity on endpoint code-thanos-sidecar-1 (48e16fba5219b405c9b20a87b006a23c87f6b1d39fe3b1127b9b16aef6ee59da): Bind for 0.0.0.0:10921 failed: port is already allocated

----------------

remove from query the port gpt could not do it
![alt text](/Resources/error-remove-the-port-from-thanos-query.png.png)