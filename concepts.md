# Docker & Kubernetes Command Reference

A quick reference for commonly used **Docker, Docker Compose, Minikube, and Kubernetes** commands and concepts.

---

## 🐳 Docker Commands

### Network

**Create a Docker network**

```bash
docker network create <network_name>
```

**List Docker networks**

```bash
docker network ls
```

**Start a container using a specific network**

```bash
docker run -d --name <container_name> --network <network_name> <image_name>
```

---

### Container Access

**Execute a shell inside a running container**

```bash
docker exec -it <container_name> /bin/bash
```

---

### Volumes

**Inspect a Docker volume**

```bash
docker volume inspect <volume_name>
```

---

## 🐳 Docker Compose

**Stop and remove Compose resources**

```bash
docker compose down
```

> `docker compose down` removes the containers and networks created by Compose, but **does not remove images** by default.

Docker Compose automatically creates a default network:

```text
<project_name>_default
```

You can verify it using:

```bash
docker network ls
```

---

# ☸️ Minikube Commands

### Start Minikube

**Start Minikube using Docker as the driver**

```bash
minikube start --driver=docker
```

**Load a local Docker image into Minikube**

```bash
minikube image load <image_name>
```

---

### Services

**Get the URL of a Minikube service**

```bash
minikube service <service_name> -n <namespace_name> --url
```

---

### Ingress

**Enable Ingress in Minikube**

```bash
minikube addons enable ingress
```

---

# ☸️ Kubernetes Commands

## 📦 Pods

**Get pods**

```bash
kubectl get pods
```

**Get pods from a specific namespace**

```bash
kubectl get pods -n <namespace_name>
```

**Get detailed information about a pod**

```bash
kubectl describe pod <pod_name>
```

**Execute a shell inside a pod**

```bash
kubectl exec -it <pod_name> -- /bin/bash
```

---

## 📁 Resources

**Delete all resources defined inside a folder**

```bash
kubectl delete -f <folder_path>
```

**Get endpoints of a Service**

```bash
kubectl get endpoints <service_name>
```

---

## ⚙️ ConfigMaps & Secrets

**Check an environment variable assigned to a pod**

```bash
kubectl exec <pod_name> -- printenv <VAR_NAME>
```

This can be useful for verifying values injected from:

* ConfigMaps
* Secrets
* Environment variables

---

## 📈 Scaling

**Manually scale a Deployment**

```bash
kubectl scale deployment <deployment_name> --replicas=3
```

---

## 📊 Metrics Server

**Check system pods to verify Metrics Server**

```bash
kubectl get pods -n kube-system
```

---

# 🔄 Kubernetes Rollouts

## Rollout Status

**Check the rollout status of a Deployment**

```bash
kubectl rollout status deployment/<deployment_name>
```

---

## Rollout History

**View Deployment rollout history**

```bash
kubectl rollout history deployment/<deployment_name>
```

**Inspect a specific revision**

```bash
kubectl rollout history deployment/<deployment_name> --revision=<revision_number>
```

---

## Rollback

**Rollback to the previous version**

```bash
kubectl rollout undo deployment/<deployment_name>
```

**Rollback to a specific revision**

```bash
kubectl rollout undo deployment/<deployment_name> --to-revision=<revision_number>
```

---

# 🛡️ Kubernetes RBAC

### ServiceAccount

**WHO is making the request?**

A `ServiceAccount` represents the identity used by a Pod or application when interacting with the Kubernetes API.

---

### Role

**WHAT can they do?**

A `Role` defines which actions are allowed on Kubernetes resources **within a specific namespace**.

Examples:

* `get`
* `list`
* `watch`
* `create`
* `update`
* `delete`

---

### RoleBinding

**WHO gets those permissions?**

A `RoleBinding` connects a `Role` to a subject such as a `ServiceAccount`.

### RBAC Summary

| Resource           | Purpose                     |
| ------------------ | --------------------------- |
| **ServiceAccount** | WHO is making the request?  |
| **Role**           | WHAT can they do?           |
| **RoleBinding**    | WHO gets those permissions? |

---

# 🌐 Kubernetes Networking

## Service

A **Service** provides stable network access to Pods inside the Kubernetes cluster.

Depending on its type, a Service can also expose workloads outside the cluster.

---

## Ingress

An **Ingress** is an HTTP/HTTPS routing layer.

It receives external HTTP/HTTPS requests and routes them to the appropriate Kubernetes **Service**.

Think of it as a common entry point:

```text
External Client
      │
      ▼
   Ingress
      │
      ├──────► API Service
      │           │
      │           ▼
      │          Pods
      │
      └──────► Message Service
                  │
                  ▼
                 Pods
```

### Service vs Ingress

| Component   | Purpose                               |
| ----------- | ------------------------------------- |
| **Service** | Provides stable access to Pods        |
| **Ingress** | Routes HTTP/HTTPS traffic to Services |

> Ingress does not normally route directly to Pods. It routes traffic to a **Service**, which then forwards the traffic to the appropriate Pods.

---

# 💾 Kubernetes Storage

## `emptyDir`

`emptyDir` provides temporary storage associated with a Pod.

```text
Pod
 └── emptyDir
```

Important:

> `emptyDir` is **not persistent storage**.

When the Pod is deleted, the `emptyDir` data is also deleted.

For persistent application data, use Kubernetes storage mechanisms such as:

* PersistentVolume (PV)
* PersistentVolumeClaim (PVC)
* StorageClass

---

# Quick Concept Summary

| Concept            | Remember                                        |
| ------------------ | ----------------------------------------------- |
| **Docker Network** | Allows Docker containers to communicate         |
| **Docker Volume**  | Persistent storage for Docker containers        |
| **Minikube**       | Local Kubernetes environment                    |
| **Pod**            | Smallest deployable Kubernetes unit             |
| **Service**        | Stable network access to Pods                   |
| **Ingress**        | HTTP/HTTPS routing to Services                  |
| **ConfigMap**      | Stores non-sensitive configuration              |
| **Secret**         | Stores sensitive configuration                  |
| **emptyDir**       | Temporary Pod-level storage                     |
| **PVC**            | Request for persistent storage                  |
| **Deployment**     | Manages replicated/stateless Pods               |
| **ServiceAccount** | Identity used by workloads                      |
| **Role**           | Defines permissions within a namespace          |
| **RoleBinding**    | Assigns Role permissions to a subject           |
| **Metrics Server** | Provides resource metrics such as CPU/memory    |
| **HPA**            | Automatically scales workloads based on metrics |
