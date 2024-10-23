rifaterdemsahin ➜ /workspaces/PrometheusThanosConnection (main) $ kubectl describe pod thanos-sidecar-7f9bb547b-cjgg4 -n monitoring
Name:             thanos-sidecar-7f9bb547b-cjgg4
Namespace:        monitoring
Priority:         0
Service Account:  default
Node:             minikube/192.168.49.2
Start Time:       Tue, 22 Oct 2024 15:10:40 +0000
Labels:           app=thanos-sidecar
                  pod-template-hash=7f9bb547b
Annotations:      <none>
Status:           Pending
IP:               10.244.0.23
IPs:
  IP:           10.244.0.23
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
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-nfwbj (ro)
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
  kube-api-access-nfwbj:
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
  Type     Reason          Age                    From               Message
  ----     ------          ----                   ----               -------
  Normal   Scheduled       4m                     default-scheduler  Successfully assigned monitoring/thanos-sidecar-7f9bb547b-cjgg4 to minikube
  Warning  InspectFailed   3m40s                  kubelet            Failed to inspect image "quay.io/thanos/thanos:latest": rpc error: code = Unknown desc = Cannot connect to the Docker daemon at unix:///var/run/docker.sock. Is the docker daemon running?
  Warning  Failed          3m40s                  kubelet            Error: ImageInspectError
  Normal   SandboxChanged  3m36s                  kubelet            Pod sandbox changed, it will be killed and re-created.
  Warning  Failed          3m3s (x3 over 3m56s)   kubelet            Failed to pull image "quay.io/thanos/thanos:latest": Error response from daemon: manifest for quay.io/thanos/thanos:latest not found: manifest unknown: manifest unknown
  Warning  Failed          3m3s (x3 over 3m56s)   kubelet            Error: ErrImagePull
  Normal   BackOff         2m27s (x6 over 3m55s)  kubelet            Back-off pulling image "quay.io/thanos/thanos:latest"
  Warning  Failed          2m27s (x6 over 3m55s)  kubelet            Error: ImagePullBackOff
  Normal   Pulling         2m13s (x4 over 3m59s)  kubelet            Pulling image "quay.io/thanos/thanos:latest"
@rifaterdemsahin ➜ /workspaces/PrometheusThanosConnection (main) $ 