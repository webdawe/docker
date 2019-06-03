#!/usr/bin/env bash

# Find container names with `docker container ls`

echo ">> Database IP:"
echo $(docker inspect docker-xdebug_web_1 | grep IPAddress)

# SSH into ETL App
docker exec -it --user ubuntu docker-xdebug_web_1 bash

docker exec -it docker-xdebug_web_1 bash
