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

## Connecting via XDebug
Make sure the website is in `/var/www/html/`, Nginx is configured to served pages from `/var/www/html/public`.

Update values in the `.docker.env` file
- `XDEBUG_HOST` must be equal to the IP of your local host machine. Run `ip -a` to see it, not the Docker IP.

## Configure PHPStorm using these settings
1. Configure Project Path Mappings
![PHPStorm XDebug Settings 1](wiki/xdebug-server-settings-1.png "PHPStorm XDebug Settings 1")

2. Configure PHPStorm XDebug Connection Settings
![PHPStorm XDebug Settings 2](wiki/xdebug-server-settings-2.png "PHPStorm XDebug Settings 2")

### Troubleshooting XDebug
`cat /etc/php/7.2/mods-available/xdebug.ini`

`cat /tmp/xdebug_remote.log`

`service php7.2-fpm reload`

### XDebug Resources
- https://serversforhackers.com/c/getting-xdebug-working
- https://www.jetbrains.com/help/phpstorm/troubleshooting-php-debugging.html
- https://www.jetbrains.com/help/phpstorm/configuring-xdebug.html
- https://www.jetbrains.com/help/phpstorm/creating-a-php-debug-server-configuration.html
