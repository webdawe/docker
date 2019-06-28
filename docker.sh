#!/usr/bin/env bash

# Find container names with `docker container ls`

echo ">> Database IP:"
echo $(docker inspect docker-web | grep IPAddress)

# SSH into Web App
docker exec -it --user ubuntu docker-web bash
