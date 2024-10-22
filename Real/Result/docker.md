Where are we at the docker implementation

Compose up

@rifaterdemsahin ➜ /workspaces/PrometheusThanosConnection (main) $  docker-compose -f /workspaces/PrometheusThanosConnection/SymbolsCode/Docker/docker-compose.yml up -d
WARN[0000] /workspaces/PrometheusThanosConnection/SymbolsCode/Docker/docker-compose.yml: the attribute `version` is obsolete, it will be ignored, please remove it to avoid potential confusion 
[+] Running 3/3
 ✔ Container docker-prometheus-1      Started                                                                                                                           0.2s 
 ✔ Container docker-thanos-sidecar-1  Started                                                                                                                           0.3s 
 ✔ Container docker-thanos-query-1    Started                                                                                                                           0.3s 
@rifaterdemsahin ➜ /workspaces/PrometheusThanosConnection (main) $ 