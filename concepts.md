## Commands:
 - create a docker network: `docker create network <network_name>`
 - verify network: `docker network ls`
 - start a container under a network: `docker run -d --name <container_name> --network <network_name> <image_name>`
 - exec inside a container: `docker exec -it <container_name> /bin/bash`
 - inspect a volume: `docker volume inspect <volume_name>`

### Notes:
 - docker compose down: removes the underlying containers, networks but not the images. It automatically creates the 
default networking which can be identified with name *_default.