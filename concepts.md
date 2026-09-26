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

### Notes:
 - docker compose down: removes the underlying containers, networks but not the images. It automatically creates the 
default networking which can be identified with name *_default.
 - emptyDir ≠ persistent storage, emptyDir belongs to Pod hence pod deleted emptyDir deleted.