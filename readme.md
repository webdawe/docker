### A base Docker image with Php (Xdebug), Composer, Nginx, NPM, Yarn, Redis, Prometheus Node Exporter

## PHP Settings
    post_max_size = 100M
    upload_max_filesize = 100M
    
## Base Image 
> http://phusion.github.io/baseimage-docker/

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
docker run -it docker-xebug_web_1 /bin/bash

## Delete all containers
docker rm $(docker ps -a -q)

## Delete all images
docker rmi $(docker images -q)

docker build -t docker-xebug_web . 

docker run -it docker-xebug_web

## Run the application with:
XDEBUG_HOST=192.168.0.6 docker-compose up

or using helper script
> ./develop.sh up --build

View in Chrome
> http://localhost:7000

## Building Docker Image and Pushing to Docker Cloud
docker build -t beyondlimits99/php7.2-nginx .
docker push beyondlimits99/php7.2-nginx