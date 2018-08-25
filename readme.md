## List Docker CLI commands
docker
docker container --help

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

docker run -it docker-xebug_web

# http://phusion.github.io/baseimage-docker/