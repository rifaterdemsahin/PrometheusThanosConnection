Where are we at the docker implementation

## Docker Compose Commands

### Compose Up

```sh
docker-compose -f /workspaces/PrometheusThanosConnection/SymbolsCode/Docker/docker-compose.yml up -d
```

WARN[0000] /workspaces/PrometheusThanosConnection/SymbolsCode/Docker/docker-compose.yml: the attribute `version` is obsolete, it will be ignored, please remove it to avoid potential confusion 

[+] Running 3/3
- Container docker-prometheus-1      Started (0.2s)
- Container docker-thanos-sidecar-1  Started (0.3s)
- Container docker-thanos-query-1    Started (0.3s)

### Compose Down

```sh
docker-compose -f /workspaces/PrometheusThanosConnection/SymbolsCode/Docker/docker-compose.yml down
```

Stopping and removing containers:
- docker-thanos-query-1
- docker-thanos-sidecar-1
- docker-prometheus-1

Removing network:
- symbols-code_default


# Stop the containers if they are running
docker stop docker-thanos-query-1 docker-thanos-sidecar-1 docker-prometheus-1

# Remove the containers
docker rm docker-thanos-query-1 docker-thanos-sidecar-1 docker-prometheus-1

docker stop docker-thanos-query-1 docker-thanos-sidecar-1 docker-prometheus-1 && docker rm docker-thanos-query-1 docker-thanos-sidecar-1 docker-prometheus-1