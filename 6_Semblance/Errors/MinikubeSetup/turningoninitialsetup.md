/workspaces/PrometheusThanosConnection/7_Journey/02_JourneyMiniKube_setup.sh
😄  minikube v1.34.0 on Ubuntu 20.04 (docker/amd64)
✨  Using the docker driver based on existing profile
👍  Starting "minikube" primary control-plane node in "minikube" cluster
🚜  Pulling base image v0.0.45 ...
🏃  Updating the running docker "minikube" container ...
🐳  Preparing Kubernetes v1.31.0 on Docker 27.2.0 ...
🔎  Verifying Kubernetes components...
    ▪ Using image gcr.io/k8s-minikube/storage-provisioner:v5
🌟  Enabled addons: storage-provisioner, default-storageclass
🏄  Done! kubectl is now configured to use "minikube" cluster and "default" namespace by default
configmap/prometheus-config created
deployment.apps/prometheus created
service/prometheus created
deployment.apps/thanos-sidecar created
error: the path "thanos-sidecar-service.yaml" does not exist
deployment.apps/thanos-query created
service/thanos-query created
Waiting for pods to be ready...
error: no matching resources found
error: no matching resources found
error: no matching resources found
Setup complete. Prometheus is available at http://localhost:9090
Thanos Query is available at http://localhost:10902


nothing to commit, working tree clean
@rifaterdemsahin ➜ /workspaces/PrometheusThanosConnection (main) $ kubectl get pods -A
NAMESPACE     NAME                               READY   STATUS             RESTARTS        AGE
default       prometheus-5b95b85759-gz5h8        1/1     Running            0               3m7s
default       thanos-query-6994479c8-rf2rr       0/1     ImagePullBackOff   0               3m7s
default       thanos-sidecar-5fdb4b74f8-n7bdk    0/1     ImagePullBackOff   0               3m7s
kube-system   coredns-6f6b679f8f-d69zc           1/1     Running            3 (3m51s ago)   31m
kube-system   etcd-minikube                      1/1     Running            3 (3m56s ago)   31m
kube-system   kube-apiserver-minikube            1/1     Running            3 (3m46s ago)   31m
kube-system   kube-controller-manager-minikube   1/1     Running            4 (3m56s ago)   31m
kube-system   kube-proxy-xkmzq                   1/1     Running            3 (3m56s ago)   31m
kube-system   kube-scheduler-minikube            1/1     Running            3 (3m56s ago)   31m
kube-system   storage-provisioner                1/1     Running            5 (3m56s ago)   31m
@rifaterdemsahin ➜ /workspaces/PrometheusThanosConnection (main) $ 

```bash
# Check logs for thanos-query pod
kubectl logs thanos-query-6994479c8-rf2rr

# Check logs for thanos-sidecar pod
kubectl logs thanos-sidecar-5fdb4b74f8-n7bdk
```
