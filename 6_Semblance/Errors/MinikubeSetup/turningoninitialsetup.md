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


Error from server (Forbidden): namespaces "default" is forbidden: this namespace may not be deleted
@rifaterdemsahin ➜ /workspaces/PrometheusThanosConnection (main) $ kubectl logs thanos-query-6994479c8-rf2rr
Error from server (BadRequest): container "thanos-query" in pod "thanos-query-6994479c8-rf2rr" is waiting to start: trying and failing to pull image
@rifaterdemsahin ➜ /workspaces/PrometheusThanosConnection (main) $ 



Error from server (BadRequest): container "thanos-query" in pod "thanos-query-6994479c8-rf2rr" is waiting to start: trying and failing to pull image
@rifaterdemsahin ➜ /workspaces/PrometheusThanosConnection (main) $ kubectl logs thanos-sidecar-5fdb4b74f8-n7bdk
Error from server (BadRequest): container "thanos-sidecar" in pod "thanos-sidecar-5fdb4b74f8-n7bdk" is waiting to start: trying and failing to pull image
@rifaterdemsahin ➜ /workspaces/PrometheusThanosConnection (main) $ 


### Explanation of Errors

1. **Namespace Deletion Forbidden**:
   - **Error**: `Error from server (Forbidden): namespaces "default" is forbidden: this namespace may not be deleted`
   - **Reason**: The [`default`](command:_github.copilot.openSymbolFromReferences?%5B%22%22%2C%5B%7B%22uri%22%3A%7B%22scheme%22%3A%22file%22%2C%22authority%22%3A%22%22%2C%22path%22%3A%22%2Fworkspaces%2FPrometheusThanosConnection%2F6_Semblance%2FErrors%2FMinikubeSetup%2Fturningoninitialsetup.md%22%2C%22query%22%3A%22%22%2C%22fragment%22%3A%22%22%7D%2C%22pos%22%3A%7B%22line%22%3A50%2C%22character%22%3A43%7D%7D%5D%2C%22b069f8f8-96f6-48a7-88be-13b6a86de024%22%5D "Go to definition") namespace is a system namespace in Kubernetes and cannot be deleted. It is protected to ensure the stability and operation of the cluster.

2. **Container Image Pull Failure**:
   - **Error**: `Error from server (BadRequest): container "thanos-query" in pod "thanos-query-6994479c8-rf2rr" is waiting to start: trying and failing to pull image`
   - **Reason**: The `thanos-query` container is unable to start because it is failing to pull the specified image. This could be due to:
     - Incorrect image name or tag.
     - Network issues preventing access to the image registry.
     - Authentication issues with the image registry.

3. **Repeated Container Image Pull Failure**:
   - **Error**: `Error from server (BadRequest): container "thanos-sidecar" in pod "thanos-sidecar-5fdb4b74f8-n7bdk" is waiting to start: trying and failing to pull image`
   - **Reason**: Similar to the `thanos-query` container, the `thanos-sidecar` container is also failing to pull the specified image for the same potential reasons.

### Steps to Resolve

1. **Namespace Deletion**:
   - Do not attempt to delete the [`default`](command:_github.copilot.openSymbolFromReferences?%5B%22%22%2C%5B%7B%22uri%22%3A%7B%22scheme%22%3A%22file%22%2C%22authority%22%3A%22%22%2C%22path%22%3A%22%2Fworkspaces%2FPrometheusThanosConnection%2F6_Semblance%2FErrors%2FMinikubeSetup%2Fturningoninitialsetup.md%22%2C%22query%22%3A%22%22%2C%22fragment%22%3A%22%22%7D%2C%22pos%22%3A%7B%22line%22%3A50%2C%22character%22%3A43%7D%7D%5D%2C%22b069f8f8-96f6-48a7-88be-13b6a86de024%22%5D "Go to definition") namespace. Use a different namespace for your deployments if needed.

2. **Fix Image Pull Issues**:
   - **Verify Image Name and Tag**: Ensure the image name and tag specified in your deployment YAML files are correct.
   - **Check Network Connectivity**: Ensure your Kubernetes nodes have network access to the image registry.
   - **Authenticate with Registry**: If the image is in a private registry, ensure you have configured the necessary credentials.

### Example Fix for Deployment YAML

Ensure your deployment YAML files have the correct image names and tags. For example:

#### `thanos-query-deployment.yaml`
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
 

 name

: thanos-query
spec:
  replicas: 1
  selector:
    matchLabels:
      app: thanos-query
  template:
    metadata:
      labels:
        app: thanos-query
    spec:
      containers:
      - name: thanos-query
        image: quay.io/thanos/thanos:v0.35.1  # Ensure this is the correct image and tag
        args:
        - query
        - --http-address=0.0.0.0:9091
        - --store=thanos-sidecar:10901
        ports:
        - containerPort: 9091
```

#### `thanos-sidecar-deployment.yaml`
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: thanos-sidecar
spec:
  replicas: 1
  selector:
    matchLabels:
      app: thanos-sidecar
  template:
    metadata:
      labels:
        app: thanos-sidecar
    spec:
      containers:
      - name: thanos-sidecar
        image: quay.io/thanos/thanos:v0.35.1  # Ensure this is the correct image and tag
        args:
        - sidecar
        - --tsdb.path=/var/prometheus
        - --prometheus.url=http://prometheus:9090
        - --grpc-address=0.0.0.0:10901
        - --http-address=0.0.0.0:10902
        volumeMounts:
        - name: prometheus-data
          mountPath: /var/prometheus
      volumes:
      - name: prometheus-data
        emptyDir: {}
```

### Verify and Redeploy

1. **Apply Configurations**:
   ```sh
   kubectl apply -f prometheus-deployment.yaml
   kubectl apply -f thanos-sidecar-deployment.yaml
   kubectl apply -f thanos-query-deployment.yaml
   ```

2. **Check Pod Status**:
   ```sh
   kubectl get pods
   ```

3. **Check Logs**:
   ```sh
   kubectl logs <pod-name>
   ```

Ensure the pods are running and the containers are able to pull the images successfully.