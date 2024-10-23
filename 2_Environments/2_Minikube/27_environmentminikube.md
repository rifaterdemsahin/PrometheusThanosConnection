### Setting Up a Proof of Concept Project with Prometheus and Thanos in GitHub Codespaces 🚀
In the world of cloud-based development environments, GitHub Codespaces offers a powerful platform for setting up and testing various projects. Today, we'll walk through creating a proof of concept (PoC) project with Prometheus and Thanos, complete with emojis to make the process more engaging! 🌟

#### Step 1: Set Up GitHub Codespaces

1. **Create a Repository**:
  - Start by creating a new repository on GitHub for your PoC project. 📂

2. **Open in Codespaces**:
  - Navigate to your repository on GitHub.
  - Click on the `Code` button and select `Open with Codespaces`.
  - Create a new Codespace or open an existing one. 🚀

#### Step 2: Prepare the Environment

Minikube start

1. **Install Minikube**:
  - Ensure Minikube is installed and running in your Codespace. 🐳

2. **Start Minikube**:
  - Run the following command to start Minikube:

   ```bash
   minikube start
   ```

3. **Create Kubernetes Manifests**:
  - Create Kubernetes manifests to define the deployments and services for Prometheus and Thanos.

```yaml
# prometheus-deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: prometheus
spec:
  replicas: 1
  selector:
   matchLabels:
    app: prometheus
  template:
   metadata:
    labels:
      app: prometheus
   spec:
    containers:
    - name: prometheus
      image: prom/prometheus:latest
      ports:
      - containerPort: 9090
      volumeMounts:
      - name: prometheus-config
       mountPath: /etc/prometheus
    volumes:
    - name: prometheus-config
      configMap:
       name: prometheus-config
---
# prometheus-service.yaml
apiVersion: v1
kind: Service
metadata:
  name: prometheus
spec:
  type: NodePort
  ports:
  - port: 9090
   targetPort: 9090
   nodePort: 30000
  selector:
   app: prometheus
---
# thanos-sidecar-deployment.yaml
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
      image: quay.io/thanos/thanos:latest
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
---
# thanos-query-deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: thanos-query
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
      image: quay.io/thanos/thanos:latest
      args:
      - query
      - --http-address=0.0.0.0:9091
      - --store=thanos-sidecar:10901
      ports:
      - containerPort: 9091
---
# thanos-query-service.yaml
apiVersion: v1
kind: Service
metadata:
  name: thanos-query
spec:
  type: NodePort
  ports:
  - port: 9091
   targetPort: 9091
   nodePort: 30001
  selector:
   app: thanos-query
```

4. **Create Prometheus Configuration**:
  - Create a `ConfigMap` for Prometheus configuration.

```yaml
# prometheus-config.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: prometheus-config
data:
  prometheus.yml: |
   global:
    scrape_interval: 15s

   scrape_configs:
    - job_name: 'prometheus'
      static_configs:
       - targets: ['localhost:9090']
```

#### Step 3: Deploy the Services


/workspaces/PrometheusThanosConnection/7_Journey/02_JourneyMiniKube_setup.sh

1. **Apply Kubernetes Manifests**:
  - Run the following commands to deploy the services:

   ```bash
   kubectl apply -f prometheus-deployment.yaml
   kubectl apply -f prometheus-service.yaml
   kubectl apply -f thanos-sidecar-deployment.yaml
   kubectl apply -f thanos-query-deployment.yaml
   kubectl apply -f thanos-query-service.yaml
   kubectl apply -f prometheus-config.yaml
   ```

2. **Verify the Setup**:
  - Access Prometheus at `http://$(minikube ip):30000`. 🌐
  - Access Thanos Query at `http://$(minikube ip):30001`. 🌐

#### Step 4: Test the Setup

1. **Add Metrics**:
  - Add some sample metrics to Prometheus and verify they are being scraped. 📊

2. **Query Metrics**:
  - Use Thanos Query to query the metrics stored in Prometheus. 🔍

#### Step 5: Clean Up

1. **Stop Minikube**:
  - Run the following command to stop Minikube:

   ```bash
   minikube stop
   ```

### Conclusion

By following these steps, you can set up a proof of concept project with Prometheus and Thanos in GitHub Codespaces using Minikube. This setup allows you to explore the integration and capabilities of these tools in a cloud-based development environment. Happy coding! 🎉

If you have any questions or need further assistance, feel free to ask! 😊

---

Feel free to copy and paste this blog post into your WordPress site. If you need any more help, just let me know!
