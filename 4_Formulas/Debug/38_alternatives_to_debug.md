
@rifaterdemsahin ➜ /workspaces/PrometheusThanosConnection (main) $ kubectl logs thanos-sidecar-7f9bb547b-qdl8g -n monitoring
Error from server (BadRequest): container "thanos-sidecar" in pod "tha

## Alternatives to Check Thanos Sidecar Logs

1. **Describe Pod to Check Events**
  ```sh
  kubectl describe pod thanos-sidecar-7f9bb547b-qdl8g -n monitoring
  ```

  Error from server (BadRequest): container "thanos-sidecar" in pod "thanos-sidecar-7f9bb547b-qdl8g" is waiting to start: trying and failing to pull image
@rifaterdemsahin ➜ /workspaces/PrometheusThanosConnection (main) $   kubectl describe pod thanos-sidecar-7f9bb547b-qdl8g -n monitoring
Name:             thanos-sidecar-7f9bb547b-qdl8g
Namespace:        monitoring
Priority:         0
Service Account:  default
Node:             minikube/192.168.49.2
Start Time:       Wed, 23 Oct 2024 12:07:26 +0000
Labels:           app=thanos-sidecar
                  pod-template-hash=7f9bb547b
Annotations:      <none>
Status:           Pending
IP:               10.244.0.17
IPs:
  IP:           10.244.0.17
Controlled By:  ReplicaSet/thanos-sidecar-7f9bb547b
Containers:
  thanos-sidecar:
    Container ID:  
    Image:         quay.io/thanos/thanos:latest
    Image ID:      
    Port:          <none>
    Host Port:     <none>
    Args:
      sidecar
      --tsdb.path=/var/prometheus
      --prometheus.url=http://prometheus:9090
      --grpc-address=0.0.0.0:10901
      --http-address=0.0.0.0:10902
    State:          Waiting
      Reason:       ImagePullBackOff
    Ready:          False
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/prometheus from prometheus-data (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-jvkpx (ro)
Conditions:
  Type                        Status
  PodReadyToStartContainers   True 
  Initialized                 True 
  Ready                       False 
  ContainersReady             False 
  PodScheduled                True 
Volumes:
  prometheus-data:
    Type:       EmptyDir (a temporary directory that shares a pod's lifetime)
    Medium:     
    SizeLimit:  <unset>
  kube-api-access-jvkpx:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type     Reason          Age                   From               Message
  ----     ------          ----                  ----               -------
  Normal   Scheduled       12m                   default-scheduler  Successfully assigned monitoring/thanos-sidecar-7f9bb547b-qdl8g to minikube
  Normal   SandboxChanged  12m                   kubelet            Pod sandbox changed, it will be killed and re-created.
  Warning  Failed          11m (x6 over 12m)     kubelet            Error: ImagePullBackOff
  Normal   Pulling         11m (x4 over 12m)     kubelet            Pulling image "quay.io/thanos/thanos:latest"
  Warning  Failed          11m (x4 over 12m)     kubelet            Failed to pull image "quay.io/thanos/thanos:latest": Error response from daemon: manifest for quay.io/thanos/thanos:latest not found: manifest unknown: manifest unknown
  Warning  Failed          11m (x4 over 12m)     kubelet            Error: ErrImagePull
  Normal   BackOff         2m43s (x42 over 12m)  kubelet            Back-off pulling image "quay.io/thanos/thanos:latest"
@rifaterdemsahin ➜ /workspaces/PrometheusThanosConnection (main) $ 




2. **Check All Logs in the Namespace**
  ```sh
  kubectl logs -l app=thanos-sidecar -n monitoring --all-containers=true
  ```

3. **Get Pod Status**
  ```sh
  kubectl get pod thanos-sidecar-7f9bb547b-qdl8g -n monitoring -o yaml
  ```

4. **Check Container Logs with Previous Flag**
  ```sh
  kubectl logs thanos-sidecar-7f9bb547b-qdl8g -n monitoring --previous
  ```