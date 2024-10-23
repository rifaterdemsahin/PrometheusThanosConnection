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

