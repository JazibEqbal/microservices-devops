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


# ☸️ Kubernetes Common Errors

| Error / Symptom              | Root Cause                                 | Fix / Check                                       |
| ---------------------------- | ------------------------------------------ | ------------------------------------------------- |
| `ImagePullBackOff`           | Wrong image/tag or registry issue          | Check image name, tag, registry credentials       |
| `ErrImagePull`               | Image cannot be pulled                     | Verify image, registry access, `imagePullSecrets` |
| `CrashLoopBackOff`           | Container repeatedly crashes               | Check `kubectl logs <pod> --previous`             |
| `CreateContainerConfigError` | Missing ConfigMap/Secret/key               | Check Pod references and ConfigMap/Secret         |
| `Pending` Pod                | Insufficient resources or scheduling issue | `kubectl describe pod` → check Events             |
| `Insufficient cpu/memory`    | Node lacks requested resources             | Reduce requests or add/scale nodes                |
| `ContainerCreating` stuck    | Volume, network, image, or secret issue    | `kubectl describe pod` → check Events             |
| `FailedMount`                | PVC/PV/storage problem                     | Check PVC, PV and StorageClass                    |
| `PVC Pending`                | No matching PV / StorageClass issue        | Check `kubectl get pvc,pv,sc`                     |
| Service has no endpoints     | Selector doesn't match Pod labels          | Compare Service selector with Pod labels          |
| `Connection refused`         | App not listening on expected port         | Check app port and Service `targetPort`           |
| Service not reachable        | Wrong selector/port/network policy         | Check Service → Endpoints → Pod                   |
| Ingress `502/503`            | Backend Service/Pod unavailable            | Check Ingress → Service → Endpoints               |
| Readiness probe failed       | App not ready or wrong probe config        | Check probe path, port and app                    |
| Liveness probe failed        | App unhealthy or probe too aggressive      | Check logs and probe configuration                |
| `OOMKilled`                  | Container exceeded memory limit            | Increase memory limit or fix memory usage         |
| `Exit Code 1`                | Application/process error                  | Check `kubectl logs <pod>`                        |
| `Forbidden`                  | RBAC permission denied                     | Check ServiceAccount, Role and RoleBinding        |
| DNS failure                  | CoreDNS or wrong Service name              | Check CoreDNS and Service DNS name                |
| `NodeNotReady`               | Kubelet/runtime/node issue                 | `kubectl describe node <node>`                    |
| Deployment rollout stuck     | New Pods not becoming Ready                | Check Deployment, Pods and Events                 |
| HPA not scaling              | Metrics unavailable / requests missing     | Check Metrics Server and HPA                      |
| Pod stuck `Terminating`      | Finalizer, volume, or node issue           | Check finalizers and node status                  |

## Debugging Flow

### Pod Issue

`get pods` → `describe pod` → `logs` → `logs --previous`

### Service Issue

`Service` → `Selector` → `Endpoints` → `Pod labels` → `targetPort`

### Ingress Issue

`Ingress` → `Service` → `Endpoints` → `Pod` → `Readiness`

### Scheduling Issue

`Pod Events` → `Resources` → `Taints/Tolerations` → `Affinity`

### Storage Issue

`Pod` → `PVC` → `PV` → `StorageClass`

## Must Know Commands

```bash
kubectl get pods
kubectl describe pod <pod>
kubectl logs <pod>
kubectl logs <pod> --previous
kubectl get svc,endpoints
kubectl get pvc,pv,sc
kubectl get events --sort-by=.lastTimestamp
kubectl describe node <node>
kubectl rollout status deployment/<name>
kubectl get hpa
```

# ☸️ Kubernetes Troubleshooting

|  # | Interview Question                                              | One-Line Answer                                                                                                  |
| -: | --------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------- |
|  1 | **Pod is stuck in `Pending`. What do you check?**               | Check `kubectl describe pod` Events for resources, taints, affinity, nodeSelector, or PVC issues.                |
|  2 | **Pod is in `CrashLoopBackOff`. What do you do?**               | Check `kubectl logs <pod> --previous` and inspect the container's command, environment, and application error.   |
|  3 | **Pod shows `ImagePullBackOff`. What could be wrong?**          | Verify image name/tag, registry access, and `imagePullSecrets`.                                                  |
|  4 | **Pod is `Running` but application is not accessible. Why?**    | Check Service selector, Endpoints, `targetPort`, container port, and whether the app is listening correctly.     |
|  5 | **Service has no Endpoints. What is the likely cause?**         | The Service selector does not match the labels on the target Pods, or Pods aren't Ready.                         |
|  6 | **Service returns `Connection refused`. What do you check?**    | Verify that the application is listening on the expected port and that Service `targetPort` matches it.          |
|  7 | **Ingress returns `502/503`. How do you troubleshoot?**         | Trace `Ingress → Service → Endpoints → Pod` and verify backend port and readiness.                               |
|  8 | **Container is getting `OOMKilled`. Why?**                      | The container exceeded its memory limit; check memory usage and resource limits/requests.                        |
|  9 | **Readiness probe keeps failing. What does it mean?**           | Kubernetes considers the application not ready; verify the probe path, port, timing, and application health.     |
| 10 | **Liveness probe keeps failing. What happens?**                 | Kubernetes restarts the container; check application health and whether the probe is too aggressive.             |
| 11 | **PVC is stuck in `Pending`. What do you check?**               | Check available PVs, StorageClass, access mode, capacity, and storage provisioner.                               |
| 12 | **Pod shows `FailedMount`. What could cause it?**               | Check PVC/PV binding, StorageClass, volume configuration, and mount permissions.                                 |
| 13 | **Pod is scheduled on no node. How do you debug it?**           | Check Pod Events, CPU/memory requests, taints/tolerations, nodeSelector, and affinity rules.                     |
| 14 | **A Pod cannot resolve a Service name. What do you check?**     | Test DNS from inside the Pod and check CoreDNS plus the Service name/namespace.                                  |
| 15 | **Pod cannot communicate with another Pod. What do you check?** | Verify Pod IPs, Services, ports, NetworkPolicies, and whether both applications are listening.                   |
| 16 | **`kubectl` returns `Forbidden`. What is the issue?**           | The current user or ServiceAccount lacks the required RBAC permission.                                           |
| 17 | **Deployment rollout is stuck. How do you investigate?**        | Run `kubectl rollout status` and inspect the new ReplicaSet, Pods, Events, and readiness failures.               |
| 18 | **HPA is not scaling Pods. What do you check?**                 | Check Metrics Server, HPA status, resource requests, and target utilization.                                     |
| 19 | **Pod is stuck in `Terminating`. What could be wrong?**         | Check finalizers, volume detach issues, node health, and whether graceful termination is blocked.                |
| 20 | **Node shows `NotReady`. What do you check first?**             | Run `kubectl describe node` and investigate kubelet, container runtime, networking, disk, and memory conditions. |

---