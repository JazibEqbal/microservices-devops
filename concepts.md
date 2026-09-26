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

### Notes:
 - docker compose down: removes the underlying containers, networks but not the images. It automatically creates the 
default networking which can be identified with name *_default.
 - emptyDir ≠ persistent storage, emptyDir belongs to Pod hence pod deleted emptyDir deleted.