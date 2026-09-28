## Commands:
 - create a docker network: `docker create network <network_name>`
 - verify network: `docker network ls`
 - start a container under a network: `docker run -d --name <container_name> --network <network_name> <image_name>`
 - exec inside a container: `docker exec -it <container_name> /bin/bash`
 - inspect a volume: `docker volume inspect <volume_name>`
 - load a local image into Minikube: `minikube image load <image-name>`
 - start Minikube as docker: `minikube start --driver=docker`
 - exec inside a pod: `kubectl exec -it <pod_name> -- /bin/bash`
 - delete all resources within a folder: `kubectl delete -f <folder_path>`
 - get detailed information of a pod: `kubectl describe pod <pod_name>`
 - check config map & secrets assigned to a pod: `kubectl exec <pod_name> -- printenv <VAR_NAME>`
 - get endpoints: `kubectl get endpoints <app_name>`
 - manual scale a deployment via cli: `kubectl scale deployment <app_name> --replicas=3`
 - Check Metrics Server: `kubectl get pods -n kube-system`
 - Enable Ingress in Minikube: `minikube addons enable ingress`
 - Rollout deployment status: `kubectl rollout status deployment/<deployment_name>`
 - Rollout deployment history: `kubectl rollout history deployment/<deployment_name>`
 - Inspect a rollout: `kubectl rollout history deployment/<deployment_name>  --revision=<revision_number>`
 - Rollback to previous version: `kubectl rollout undo deployment/<deployment_name>`
 - Rollback to a particular version:`kubectl rollout undo deployment <deployment-name> --to-revision=<revision-number>`
 - Get pods under a namespace: `kubectl get pods -n <namespace_name>`

### Notes:
 - docker compose down: removes the underlying containers, networks but not the images. It automatically creates the 
default networking which can be identified with name *_default.
 - emptyDir ≠ persistent storage, emptyDir belongs to Pod hence pod deleted emptyDir deleted.
 - Ingress is a traffic router that receives external HTTP/HTTPS requests and sends them to the correct Kubernetes Service i.e., it acts as the common entry point.
 - The Ingress is essentially an HTTP routing layer.
 - A Service provides stable access inside the Kubernetes cluster and can also expose workloads externally depending on its type.
   While ingress provides HTTP/HTTPS routing to Services.