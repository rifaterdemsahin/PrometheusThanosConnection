# Debugging Resource Constraints in Kubernetes

When dealing with errors related to resource constraints in a Kubernetes cluster, you can use the following `kubectl` commands to gather information and debug the issues:

## Check Pod Resource Requests and Limits

```sh
kubectl get pods -o=jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.spec.containers[*].resources}{"\n"}{end}' -n monitoring
```

@rifaterdemsahin ➜ /workspaces/PrometheusThanosConnection (main) $ kubectl get pods -o=jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.spec.containers[*].resources}{"\n"}{end}' -n monitoring
prometheus-5b95b85759-b9flk     {}
thanos-query-5df49cc4c4-x4gxn   {}
thanos-sidecar-68996566c8-mkjpq {}
@rifaterdemsahin ➜ /workspaces/PrometheusThanosConnection (main) $ 

## Describe Pods to See Resource Usage

```sh
kubectl describe pod <pod-name>

kubectl describe pod thanos-sidecar-68996566c8-mkjpq
```

monitoring    prometheus-5b95b85759-b9flk        1/1     Running            0             77s
monitoring    thanos-query-5df49cc4c4-x4gxn      1/1     Running            0             77s
monitoring    thanos-sidecar-68996566c8-mkjpq    0/1     CrashLoopBackOff   3 (16s ago)   77s
@rifaterdemsahin ➜ /workspaces/PrometheusThanosConnection (main) $ kubectl get pods -o=jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.spec.containers[*].resources}{"\n"}{end}'
@rifaterdemsahin ➜ /workspaces/PrometheusThanosConnection (main) $ kubectl get pods -o=jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.spec.containers[*].resources}{"\n"}{end}' - monitoring^C
@rifaterdemsahin ➜ /workspaces/PrometheusThanosConnection (main) $ kubectl get pods -o=jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.spec.containers[*].resources}{"\n"}{end}' -n monitoring
prometheus-5b95b85759-b9flk     {}
thanos-query-5df49cc4c4-x4gxn   {}
thanos-sidecar-68996566c8-mkjpq {}
@rifaterdemsahin ➜ /workspaces/PrometheusThanosConnection (main) $ kubectl describe pod thanos-sidecar-68996566c8-mkjpq
Error from server (NotFound): pods "thanos-sidecar-68996566c8-mkjpq" not found
@rifaterdemsahin ➜ /workspaces/PrometheusThanosConnection (main) $ kubectl get pods -o=jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.spec.containers[*].resources}{"\n"}{end}' -n monitoring
prometheus-5b95b85759-b9flk     {}
thanos-query-5df49cc4c4-x4gxn   {}
thanos-sidecar-68996566c8-mkjpq {}
@rifaterdemsahin ➜ /workspaces/PrometheusThanosConnection (main) $ kubectl describe pod thanos-sidecar-68996566c8-mkjpq -n monitoring #
Name:             thanos-sidecar-68996566c8-mkjpq
Namespace:        monitoring
Priority:         0
Service Account:  default
Node:             minikube/192.168.49.2
Start Time:       Wed, 23 Oct 2024 13:09:13 +0000
Labels:           app=thanos-sidecar
                  pod-template-hash=68996566c8
Annotations:      <none>
Status:           Running
IP:               10.244.0.5
IPs:
  IP:           10.244.0.5
Controlled By:  ReplicaSet/thanos-sidecar-68996566c8
Containers:
  thanos-sidecar:
    Container ID:  docker://a0e05b9fe8eafe77818edcdf81602002e28e2b75bb796cedcbbdc83771121618
    Image:         quay.io/thanos/thanos:v0.35.1
    Image ID:      docker-pullable://quay.io/thanos/thanos@sha256:3c0ba6e10128e044f47fc4fcfd7652e4a5801a314415c49beedc1f19c364915f
    Port:          <none>
    Host Port:     <none>
    Args:
      sidecar
      --tsdb.path=/var/prometheus
      --prometheus.url=http://prometheus:9090
      --grpc-address=0.0.0.0:10901
      --http-address=0.0.0.0:10902
    State:          Waiting
      Reason:       CrashLoopBackOff
    Last State:     Terminated
      Reason:       Error
      Exit Code:    1
      Started:      Wed, 23 Oct 2024 13:10:54 +0000
      Finished:     Wed, 23 Oct 2024 13:10:55 +0000
    Ready:          False
    Restart Count:  4
    Environment:    <none>
    Mounts:
      /var/prometheus from prometheus-data (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-tm5nl (ro)
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
  kube-api-access-tm5nl:
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
  Type     Reason     Age                  From               Message
  ----     ------     ----                 ----               -------
  Normal   Scheduled  3m5s                 default-scheduler  Successfully assigned monitoring/thanos-sidecar-68996566c8-mkjpq to minikube
  Normal   Pulling    3m4s                 kubelet            Pulling image "quay.io/thanos/thanos:v0.35.1"
  Normal   Pulled     2m46s                kubelet            Successfully pulled image "quay.io/thanos/thanos:v0.35.1" in 2.367s (18.532s including waiting). Image size: 209484973 bytes.
  Normal   Created    84s (x5 over 2m46s)  kubelet            Created container thanos-sidecar
  Normal   Started    84s (x5 over 2m46s)  kubelet            Started container thanos-sidecar
  Normal   Pulled     84s (x4 over 2m45s)  kubelet            Container image "quay.io/thanos/thanos:v0.35.1" already present on machine
  Warning  BackOff    71s (x9 over 2m44s)  kubelet            Back-off restarting failed container thanos-sidecar in pod thanos-sidecar-68996566c8-mkjpq_monitoring(565a0575-f7c8-413b-bd3d-9bd67692b99f)
@rifaterdemsahin ➜ /workspaces/PrometheusThanosConnection (main) $ ^C

## Check Node Resource Usage

```sh
kubectl top nodes
```

@rifaterdemsahin ➜ /workspaces/PrometheusThanosConnection (main) $ kubectl top nodes
error: Metrics API not available

## Check Pod Resource Usage

```sh
kubectl top pods
```

@rifaterdemsahin ➜ /workspaces/PrometheusThanosConnection (main) $ kubectl top nodes
error: Metrics API not available
@rifaterdemsahin ➜ /workspaces/PrometheusThanosConnection (main) $ kubectl top pods
error: Metrics API not available

## Get Events for a Specific Namespace

```sh
kubectl get events --namespace=<namespace>
kubectl get events --namespace=monitoring
```

ifaterdemsahin ➜ /workspaces/PrometheusThanosConnection (main) $ kubectl get events --namespace=monitoring
LAST SEEN   TYPE      REASON              OBJECT                                 MESSAGE
5m41s       Normal    Scheduled           pod/prometheus-5b95b85759-b9flk        Successfully assigned monitoring/prometheus-5b95b85759-b9flk to minikube
5m40s       Normal    Pulling             pod/prometheus-5b95b85759-b9flk        Pulling image "prom/prometheus:latest"
5m32s       Normal    Pulled              pod/prometheus-5b95b85759-b9flk        Successfully pulled image "prom/prometheus:latest" in 8.059s (8.059s including waiting). Image size: 290081212 bytes.
5m32s       Normal    Created             pod/prometheus-5b95b85759-b9flk        Created container prometheus
5m32s       Normal    Started             pod/prometheus-5b95b85759-b9flk        Started container prometheus
5m41s       Normal    SuccessfulCreate    replicaset/prometheus-5b95b85759       Created pod: prometheus-5b95b85759-b9flk
5m41s       Normal    ScalingReplicaSet   deployment/prometheus                  Scaled up replica set prometheus-5b95b85759 to 1
5m41s       Normal    Scheduled           pod/thanos-query-5df49cc4c4-x4gxn      Successfully assigned monitoring/thanos-query-5df49cc4c4-x4gxn to minikube
5m40s       Normal    Pulling             pod/thanos-query-5df49cc4c4-x4gxn      Pulling image "quay.io/thanos/thanos:v0.35.1"
5m24s       Normal    Pulled              pod/thanos-query-5df49cc4c4-x4gxn      Successfully pulled image "quay.io/thanos/thanos:v0.35.1" in 8.135s (16.191s including waiting). Image size: 209484973 bytes.
5m24s       Normal    Created             pod/thanos-query-5df49cc4c4-x4gxn      Created container thanos-query
5m24s       Normal    Started             pod/thanos-query-5df49cc4c4-x4gxn      Started container thanos-query
5m41s       Normal    SuccessfulCreate    replicaset/thanos-query-5df49cc4c4     Created pod: thanos-query-5df49cc4c4-x4gxn
5m41s       Normal    ScalingReplicaSet   deployment/thanos-query                Scaled up replica set thanos-query-5df49cc4c4 to 1
5m41s       Normal    Scheduled           pod/thanos-sidecar-68996566c8-mkjpq    Successfully assigned monitoring/thanos-sidecar-68996566c8-mkjpq to minikube
5m40s       Normal    Pulling             pod/thanos-sidecar-68996566c8-mkjpq    Pulling image "quay.io/thanos/thanos:v0.35.1"
5m22s       Normal    Pulled              pod/thanos-sidecar-68996566c8-mkjpq    Successfully pulled image "quay.io/thanos/thanos:v0.35.1" in 2.367s (18.532s including waiting). Image size: 209484973 bytes.
4m          Normal    Created             pod/thanos-sidecar-68996566c8-mkjpq    Created container thanos-sidecar
4m          Normal    Started             pod/thanos-sidecar-68996566c8-mkjpq    Started container thanos-sidecar
4m          Normal    Pulled              pod/thanos-sidecar-68996566c8-mkjpq    Container image "quay.io/thanos/thanos:v0.35.1" already present on machine
37s         Warning   BackOff             pod/thanos-sidecar-68996566c8-mkjpq    Back-off restarting failed container thanos-sidecar in pod thanos-sidecar-68996566c8-mkjpq_monitoring(565a0575-f7c8-413b-bd3d-9bd67692b99f)
5m41s       Normal    SuccessfulCreate    replicaset/thanos-sidecar-68996566c8   Created pod: thanos-sidecar-68996566c8-mkjpq
5m41s       Normal    ScalingReplicaSet   deployment/thanos-sidecar              Scaled up replica set thanos-sidecar-68996566c8 to 1
@rifaterdemsahin ➜ /workspaces/PrometheusThanosConnection (main) $ ^C

## Check for Pending Pods and Their Reasons

```sh
kubectl get pods --all-namespaces | grep Pending
```

## Describe Nodes to See Allocatable Resources

```sh
kubectl describe nodes
```

rifaterdemsahin ➜ /workspaces/PrometheusThanosConnection (main) $ kubectl describe nodes
Name:               minikube
Roles:              control-plane
Labels:             beta.kubernetes.io/arch=amd64
                    beta.kubernetes.io/os=linux
                    kubernetes.io/arch=amd64
                    kubernetes.io/hostname=minikube
                    kubernetes.io/os=linux
                    minikube.k8s.io/commit=210b148df93a80eb872ecbeb7e35281b3c582c61
                    minikube.k8s.io/name=minikube
                    minikube.k8s.io/primary=true
                    minikube.k8s.io/updated_at=2024_10_23T13_09_08_0700
                    minikube.k8s.io/version=v1.34.0
                    node-role.kubernetes.io/control-plane=
                    node.kubernetes.io/exclude-from-external-load-balancers=
Annotations:        kubeadm.alpha.kubernetes.io/cri-socket: unix:///var/run/cri-dockerd.sock
                    node.alpha.kubernetes.io/ttl: 0
                    volumes.kubernetes.io/controller-managed-attach-detach: true
CreationTimestamp:  Wed, 23 Oct 2024 13:09:05 +0000
Taints:             <none>
Unschedulable:      false
Lease:
  HolderIdentity:  minikube
  AcquireTime:     <unset>
  RenewTime:       Wed, 23 Oct 2024 13:15:48 +0000
Conditions:
  Type             Status  LastHeartbeatTime                 LastTransitionTime                Reason                       Message
  ----             ------  -----------------                 ------------------                ------                       -------
  MemoryPressure   False   Wed, 23 Oct 2024 13:14:46 +0000   Wed, 23 Oct 2024 13:09:04 +0000   KubeletHasSufficientMemory   kubelet has sufficient memory available
  DiskPressure     False   Wed, 23 Oct 2024 13:14:46 +0000   Wed, 23 Oct 2024 13:09:04 +0000   KubeletHasNoDiskPressure     kubelet has no disk pressure
  PIDPressure      False   Wed, 23 Oct 2024 13:14:46 +0000   Wed, 23 Oct 2024 13:09:04 +0000   KubeletHasSufficientPID      kubelet has sufficient PID available
  Ready            True    Wed, 23 Oct 2024 13:14:46 +0000   Wed, 23 Oct 2024 13:09:06 +0000   KubeletReady                 kubelet is posting ready status
Addresses:
  InternalIP:  192.168.49.2
  Hostname:    minikube
Capacity:
  cpu:                4
  ephemeral-storage:  32847680Ki
  hugepages-1Gi:      0
  hugepages-2Mi:      0
  memory:             16364588Ki
  pods:               110
Allocatable:
  cpu:                4
  ephemeral-storage:  32847680Ki
  hugepages-1Gi:      0
  hugepages-2Mi:      0
  memory:             16364588Ki
  pods:               110
System Info:
  Machine ID:                 e68b42c81f0446d99faa4e4096759d30
  System UUID:                dc91e45c-5f63-45a3-9d83-8934fac699ec
  Boot ID:                    6fa6e36f-6037-4e17-af14-bbef3cb4486f
  Kernel Version:             6.5.0-1025-azure
  OS Image:                   Ubuntu 22.04.4 LTS
  Operating System:           linux
  Architecture:               amd64
  Container Runtime Version:  docker://27.2.0
  Kubelet Version:            v1.31.0
  Kube-Proxy Version:         
PodCIDR:                      10.244.0.0/24
PodCIDRs:                     10.244.0.0/24
Non-terminated Pods:          (10 in total)
  Namespace                   Name                                CPU Requests  CPU Limits  Memory Requests  Memory Limits  Age
  ---------                   ----                                ------------  ----------  ---------------  -------------  ---
  kube-system                 coredns-6f6b679f8f-9zdmg            100m (2%)     0 (0%)      70Mi (0%)        170Mi (1%)     6m35s
  kube-system                 etcd-minikube                       100m (2%)     0 (0%)      100Mi (0%)       0 (0%)         6m41s
  kube-system                 kube-apiserver-minikube             250m (6%)     0 (0%)      0 (0%)           0 (0%)         6m41s
  kube-system                 kube-controller-manager-minikube    200m (5%)     0 (0%)      0 (0%)           0 (0%)         6m41s
  kube-system                 kube-proxy-lgm24                    0 (0%)        0 (0%)      0 (0%)           0 (0%)         6m36s
  kube-system                 kube-scheduler-minikube             100m (2%)     0 (0%)      0 (0%)           0 (0%)         6m41s
  kube-system                 storage-provisioner                 0 (0%)        0 (0%)      0 (0%)           0 (0%)         6m39s
  monitoring                  prometheus-5b95b85759-b9flk         0 (0%)        0 (0%)      0 (0%)           0 (0%)         6m35s
  monitoring                  thanos-query-5df49cc4c4-x4gxn       0 (0%)        0 (0%)      0 (0%)           0 (0%)         6m35s
  monitoring                  thanos-sidecar-68996566c8-mkjpq     0 (0%)        0 (0%)      0 (0%)           0 (0%)         6m35s
Allocated resources:
  (Total limits may be over 100 percent, i.e., overcommitted.)
  Resource           Requests    Limits
  --------           --------    ------
  cpu                750m (18%)  0 (0%)
  memory             170Mi (1%)  170Mi (1%)
  ephemeral-storage  0 (0%)      0 (0%)
  hugepages-1Gi      0 (0%)      0 (0%)
  hugepages-2Mi      0 (0%)      0 (0%)
Events:
  Type    Reason                   Age    From             Message
  ----    ------                   ----   ----             -------
  Normal  Starting                 6m34s  kube-proxy       
  Normal  Starting                 6m41s  kubelet          Starting kubelet.
  Normal  NodeAllocatableEnforced  6m41s  kubelet          Updated Node Allocatable limit across pods
  Normal  NodeHasSufficientMemory  6m40s  kubelet          Node minikube status is now: NodeHasSufficientMemory
  Normal  NodeHasNoDiskPressure    6m40s  kubelet          Node minikube status is now: NodeHasNoDiskPressure
  Normal  NodeHasSufficientPID     6m40s  kubelet          Node minikube status is now: NodeHasSufficientPID
  Normal  RegisteredNode           6m36s  node-controller  Node minikube event: Registered Node minikube in Controller
@rifaterdemsahin ➜ /workspaces/PrometheusThanosConnection (main) $ 

These commands will help you identify and troubleshoot resource constraints in your Kubernetes cluster.

htop to see the resouces