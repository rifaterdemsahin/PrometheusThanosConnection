# Debugging Resource Constraints in Kubernetes

When dealing with errors related to resource constraints in a Kubernetes cluster, you can use the following `kubectl` commands to gather information and debug the issues:

## Check Pod Resource Requests and Limits

```sh
kubectl get pods -o=jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.spec.containers[*].resources}{"\n"}{end}'
```

## Describe Pods to See Resource Usage

```sh
kubectl describe pod <pod-name>
```

## Check Node Resource Usage

```sh
kubectl top nodes
```

## Check Pod Resource Usage

```sh
kubectl top pods
```

## Get Events for a Specific Namespace

```sh
kubectl get events --namespace=<namespace>
```

## Check for Pending Pods and Their Reasons

```sh
kubectl get pods --all-namespaces | grep Pending
```

## Describe Nodes to See Allocatable Resources

```sh
kubectl describe nodes
```

These commands will help you identify and troubleshoot resource constraints in your Kubernetes cluster.

htop to see the resouces