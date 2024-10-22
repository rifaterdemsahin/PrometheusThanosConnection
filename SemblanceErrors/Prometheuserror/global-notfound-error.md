 *  Executing task: docker logs --tail 1000 -f 2390dac838d501ac58e3c5addfa6d13a53200b7f36f826030adcd3d6153e7f0d 

ts=2024-10-22T12:32:26.073453474Z caller=sidecar.go:139 level=info msg="no supported bucket was configured, uploads will be disabled"
ts=2024-10-22T12:32:26.075895916Z caller=sidecar.go:215 level=info msg="successfully loaded prometheus version"
ts=2024-10-22T12:32:26.077014426Z caller=sidecar.go:238 level=info msg="successfully loaded prometheus external labels" external_labels={}
ts=2024-10-22T12:32:26.077104604Z caller=main.go:145 level=error err="no external labels configured on Prometheus server, uniquely identifying external labels must be configured; see https://thanos.io/tip/thanos/storage.md#external-labels for details.\nmain.runSidecar\n\t/app/cmd/thanos/sidecar.go:249\nmain.registerSidecar.func1\n\t/app/cmd/thanos/sidecar.go:104\nmain.main\n\t/app/cmd/thanos/main.go:143\nruntime.main\n\t/usr/local/go/src/runtime/proc.go:267\nruntime.goexit\n\t/usr/local/go/src/runtime/asm_amd64.s:1650\npreparing sidecar command failed\nmain.main\n\t/app/cmd/thanos/main.go:145\nruntime.main\n\t/usr/local/go/src/runtime/proc.go:267\nruntime.goexit\n\t/usr/local/go/src/runtime/asm_amd64.s:1650"
ts=2024-10-22T12:34:39.463865433Z caller=sidecar.go:139 level=info msg="no supported bucket was configured, uploads will be disabled"
ts=2024-10-22T12:34:39.471500349Z caller=sidecar.go:215 level=info msg="successfully loaded prometheus version"
ts=2024-10-22T12:34:39.472623231Z caller=sidecar.go:238 level=info msg="successfully loaded prometheus external labels" external_labels={}
ts=2024-10-22T12:34:39.472957635Z caller=main.go:145 level=error err="no external labels configured on Prometheus server, uniquely identifying external labels must be configured; see https://thanos.io/tip/thanos/storage.md#external-labels for details.\nmain.runSidecar\n\t/app/cmd/thanos/sidecar.go:249\nmain.registerSidecar.func1\n\t/app/cmd/thanos/sidecar.go:104\nmain.main\n\t/app/cmd/thanos/main.go:143\nruntime.main\n\t/usr/local/go/src/runtime/proc.go:267\nruntime.goexit\n\t/usr/local/go/src/runtime/asm_amd64.s:1650\npreparing sidecar command failed\nmain.main\n\t/app/cmd/thanos/main.go:145\nruntime.main\n\t/usr/local/go/src/runtime/proc.go:267\nruntime.goexit\n\t/usr/local/go/src/runtime/asm_amd64.s:1650"
 *  Terminal will be reused by tasks, press any key to close it. 

 *  Executing task: docker logs --tail 1000 -f 378891e60b39f0dd6f54ba5fec64a918527df3fbce1cfe60c2e52b1115c2911f 

ts=2024-10-22T12:49:24.628Z caller=main.go:549 level=error msg="Error loading config (--config.file=/etc/prometheus/prometheus.yml)" file=/etc/prometheus/prometheus.yml err="parsing YAML file /etc/prometheus/prometheus.yml: yaml: unmarshal errors:\n  line 2: field global not found in type config.plain\n  line 9: field scrape_configs not found in type config.plain"
 *  Terminal will be reused by tasks, press any key to close it. 

 *  Executing task: docker logs --tail 1000 -f 4eec1335d1b77562009de323a6f9af254339df864e98db83a23d44a68d1abf68 

ts=2024-10-22T13:38:46.382Z caller=main.go:549 level=error msg="Error loading config (--config.file=/etc/prometheus/prometheus.yml)" file=/etc/prometheus/prometheus.yml err="parsing YAML file /etc/prometheus/prometheus.yml: yaml: unmarshal errors:\n  line 2: field global not found in type config.plain\n  line 8: field scrape_configs not found in type config.plain"
 *  Terminal will be reused by tasks, press any key to close it. 

========================================================================================================


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
======================================================================

global:
  global:
    scrape_interval: 15s
    external_labels:
      cluster: 'your-cluster-name'
      region: 'your-region'

  scrape_configs:
    - job_name: 'prometheus'
      static_configs:
        - targets: ['localhost:9090']
======================================================================

GPT OUTPUT

### Steps to Solve the Issues

#### 1. Configure External Labels in Prometheus

The Thanos sidecar requires external labels to be configured in Prometheus. Update your `prometheus.yml` file to include external labels.

#### 2. Fix YAML Parsing Errors

Ensure the `prometheus.yml` file is correctly formatted. The current configuration has a nested [`global`](command:_github.copilot.openSymbolFromReferences?%5B%22%22%2C%5B%7B%22uri%22%3A%7B%22scheme%22%3A%22file%22%2C%22authority%22%3A%22%22%2C%22path%22%3A%22%2Fworkspaces%2FPrometheusThanosConnection%2FSemblanceErrors%2FPrometheuserror%2Fglobal-notfound-error.md%22%2C%22query%22%3A%22%22%2C%22fragment%22%3A%22%22%7D%2C%22pos%22%3A%7B%22line%22%3A14%2C%22character%22%3A265%7D%7D%5D%2C%22fc10480f-65ac-46e5-a5ee-9261b127996d%22%5D "Go to definition") key which is incorrect.

### Corrected `prometheus.yml`

```yaml
global:
  scrape_interval: 15s
  external_labels:
    cluster: 'your-cluster-name'
    region: 'your-region'

scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['localhost:9090']
```

### Corrected `docker-compose.yml`

Ensure your `docker-compose.yml` correctly mounts the `prometheus.yml` file and uses the correct paths.

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
```

### Verification

1. **Restart Docker Compose Services**:
   ```sh
   docker-compose down
   docker-compose up -d
   ```

2. **Check Logs**:
   ```sh
   docker logs --tail 1000 -f <prometheus_container_id>
   docker logs --tail 1000 -f <thanos_sidecar_container_id>
   ```

Ensure there are no errors related to external labels or YAML parsing.
