@rifaterdemsahin ➜ /workspaces/PrometheusThanosConnection (main) $   docker-compose -f /workspaces/PrometheusThanosConnection/SymbolsCode/Docker/docker-compose.yml up -d
WARN[0000] /workspaces/PrometheusThanosConnection/SymbolsCode/Docker/docker-compose.yml: the attribute `version` is obsolete, it will be ignored, please remove it to avoid potential confusion 
[+] Running 17/3
 ✔ thanos-sidecar Pulled                                                                                                                                               10.5s 
 ✔ thanos-query Pulled                                                                                                                                                 10.5s 
 ✔ prometheus Pulled                                                                                                                                                    9.6s 
[+] Running 3/4
 ✔ Network docker_default             Created                                                                                                                           0.1s 
 ⠼ Container docker-prometheus-1      Starting                                                                                                                          0.4s 
 ✔ Container docker-thanos-sidecar-1  Created                                                                                                                           0.0s 
 ✔ Container docker-thanos-query-1    Created                                                                                                                           0.0s 
Error response from daemon: failed to create task for container: failed to create shim task: OCI runtime create failed: runc create failed: unable to start container process: error during container init: error mounting "/workspaces/PrometheusThanosConnection/SymbolsCode/Docker/prometheus.yml" to rootfs at "/etc/prometheus/prometheus.yml": create mount destination for /etc/prometheus/prometheus.yml mount: cannot mkdir in /var/lib/docker/overlay2/33b57b16d035835013b89e65fa3e40c0d39b91bd9481c4694f9b71033fca9590/merged/etc/prometheus/prometheus.yml: not a directory: unknown: Are you trying to mount a directory onto a file (or vice-versa)? Check if the specified host path exists and is the expected type


Missing


    volumes:

      - /workspaces/PrometheusThanosConnection/SymbolsCode/Docker/prometheus.yml:/etc/prometheus/prometheus.yml:ro
