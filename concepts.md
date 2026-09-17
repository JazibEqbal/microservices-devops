## Commands:
 - create network: `docker create network <network_name>`
 - verify network: `docker network ls`
 - start a container under a network: `docker run -d --name <service_name> --network <network_name> <image_name>`
 - exec inside a container: `docker exec -it <service_name> /bin/bash`