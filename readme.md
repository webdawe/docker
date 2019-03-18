### A base Docker image with Php (Xdebug), Composer, Nginx, NPM, Yarn, Redis, Prometheus Node Exporter

## Base Image 
> http://phusion.github.io/baseimage-docker/

Baseimage-docker only consumes 8.3 MB RAM and is much more powerful than Busybox or Alpine. See why below.

Baseimage-docker is a special Docker image that is configured for correct use within Docker containers. It is Ubuntu, plus:

- Modifications for Docker-friendliness.
- Administration tools that are especially useful in the context of Docker.
- Mechanisms for easily running multiple processes, without violating the Docker philosophy.
- You can use it as a base for your own Docker images.

## Run the application with:
```
docker-compose up --build
```

## Connect to application with:
```
docker exec -it docker-xebug_web_1 bash
```

## View site in Chrome
> http://localhost:7000

## Application has one of 3 website settings: (.docker.env)
```
app
queue
scheduler
```

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

## Docker Machine with Digital Ocean
```
docker-machine create --driver digitalocean \
    --digitalocean-image ubuntu-18-04-x64 \
    --digitalocean-access-token $DOTOKEN \
    rob-test-1
```

### See list of Docker Machines Created
```
docker-machine ls
```

### Set your Env to the machine
```
docker-machine env rob-test-1
docker-machine ip rob-test-1
```

## Login to Git Lab
```
docker login registy.gitlab.com

docker run -d --restart=unless-stopped -p 80:80 \
    registry.gitlab.com/robmellett/docker-xdebug/php:7.2
```

## Connecting via XDebug
Update values in the `.docker.env` file
- `XDEBUG_HOST` must be equal to the IP of your local host machine. Run `ip -a` to see it, not the Docker IP.

### Troubleshooting XDebug
`cat /etc/php/7.0/mods-available/xdebug.ini`

`cat /tmp/xdebug_remote.log`

`service php7.2-fpm reload`

### XDebug Resources
- https://serversforhackers.com/c/getting-xdebug-working
- https://www.jetbrains.com/help/phpstorm/troubleshooting-php-debugging.html
- https://www.jetbrains.com/help/phpstorm/configuring-xdebug.html
- https://www.jetbrains.com/help/phpstorm/creating-a-php-debug-server-configuration.html
