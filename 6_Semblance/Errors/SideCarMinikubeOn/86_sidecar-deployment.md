@rifaterdemsahin ➜ /workspaces/PrometheusThanosConnection (main) $ kubectl get pods -A
NAMESPACE     NAME                               READY   STATUS             RESTARTS        AGE
kube-system   coredns-6f6b679f8f-qbp28           1/1     Running            0               24m
kube-system   etcd-minikube                      1/1     Running            0               24m
kube-system   kube-apiserver-minikube            1/1     Running            0               24m
kube-system   kube-controller-manager-minikube   1/1     Running            0               24m
kube-system   kube-proxy-rgxg4                   1/1     Running            0               24m
kube-system   kube-scheduler-minikube            1/1     Running            0               24m
kube-system   storage-provisioner                1/1     Running            1 (24m ago)     24m
monitoring    prometheus-5b95b85759-5b2sc        1/1     Running            0               23m
monitoring    thanos-query-5df49cc4c4-ntlx9      1/1     Running            0               7m48s
monitoring    thanos-sidecar-68996566c8-g7cbb    0/1     CrashLoopBackOff   6 (2m11s ago)   7m48s
monitoring    thanos-sidecar-7f9bb547b-7zdrc     0/1     ImagePullBackOff   0               7m48s
@rifaterdemsahin ➜ /workspaces/PrometheusThanosConnection (main) $ 

@rifaterdemsahin ➜ /workspaces/PrometheusThanosConnection (main) $ kubectl get deployments -n monitoring
NAME             READY   UP-TO-DATE   AVAILABLE   AGE
prometheus       1/1     1            1           24m
thanos-query     1/1     1            1           8m40s
thanos-sidecar   0/1     1            0           8m41s



 git pull; git add . && git commit -m "Refine task priorities in kanban board" && git push;clear.exe 



 