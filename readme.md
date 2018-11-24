### A base Docker image with Php (Xdebug), Composer, Nginx, NPM, Yarn, Redis, Prometheus Node Exporter

## Base Image 
> http://phusion.github.io/baseimage-docker/

Baseimage-docker only consumes 8.3 MB RAM and is much more powerful than Busybox or Alpine. See why below.

Baseimage-docker is a special Docker image that is configured for correct use within Docker containers. It is Ubuntu, plus:

Modifications for Docker-friendliness.
Administration tools that are especially useful in the context of Docker.
Mechanisms for easily running multiple processes, without violating the Docker philosophy.
You can use it as a base for your own Docker images.

Baseimage-docker is available for pulling from the Docker registry!


## Run the application with:
```
XDEBUG_HOST=192.168.0.6 docker-compose up
```

## View in Chrome
> http://localhost:7000

## Building Docker Image and Pushing to Docker Cloud
```
docker build -t beyondlimits99/php7.2-nginx .

docker push beyondlimits99/php7.2-nginx
```

## List Docker CLI commands
```docker
docker container --help
```

## List Docker images
```
docker image ls
```
## List Docker containers (running, all, all in quiet mode)
```
docker container ls
docker container ls --all
docker container ls -aq
```
## Run Specific Image
```
docker run -it docker-xebug_web_1 /bin/bash
```

## Delete all containers
```
docker rm $(docker ps -a -q)
```

## Delete all images
```
docker rmi $(docker images -q)

docker build -t docker-xebug_web . 

docker run -it docker-xebug_web
```