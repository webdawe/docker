## List Docker CLI commands
docker
docker container --help

## Display Docker version and info
docker --version
docker version
docker info

## Execute Docker image
docker run hello-world

## List Docker images
docker image ls

## List Docker containers (running, all, all in quiet mode)
docker container ls
docker container ls --all
docker container ls -aq


## Run Specific Image
docker run -i -t docker-xebug_web /bin/bash

## Delete all containers
docker rm $(docker ps -a -q)

## Delete all images
docker rmi $(docker images -q)

docker build -t docker-xebug_web . 

docker run -d -p 4000:80 docker-xebug_web

docker run --name docker-xebug_web -it docker-xebug_web