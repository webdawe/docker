### A base Docker image with Ubuntu (18.04), Php (Xdebug), Composer, Nginx, NPM, Yarn, Prometheus Node Exporter

## Base Image 
> http://phusion.github.io/baseimage-docker/#intro

Baseimage-docker only consumes 8.3 MB RAM and is much more powerful than Busybox or Alpine. See why below.

Baseimage-docker is a special Docker image that is configured for correct use within Docker containers. It is Ubuntu, plus:

- Modifications for Docker-friendliness.
- Administration tools that are especially useful in the context of Docker.
- Mechanisms for easily running multiple processes, without violating the Docker philosophy.
- You can use it as a base for your own Docker images.

## Docker Versions
You can use the following docker images
- robmellett/lemp:7.4
- robmellett/lemp:7.3
- robmellett/lemp:7.2
- robmellett/lemp:7.1
- robmellett/lemp:7.0
- robmellett/lemp:5.6

## Getting Started
**Option 1**

`composer require robmellett/devops`
`php artisan vendor:publish  --provider="Robmellett\Devops\DevopsServiceProvider"`

And the required files will be copied into your project.


**Option 2**

Copy the following files into your project.

`./src/docker-compose.yml` and `./src/.docker.env.example.` into your project. 

## Run the application with:
```
docker-compose up --build
```

## Connect to application with:
```
docker exec -it 'acme-app' bash
```

## View site in Chrome
> https://localhost:7000

## Application has one of 3 website settings: (.docker.env)
```
app
queue
scheduler
```

## Connecting via XDebug
Make sure the website is in `/var/www/html/`, Nginx is configured to serve pages from `/var/www/html/public`.

Update values in the `.docker.env` file
- `XDEBUG_HOST` must be equal to the IP of your local host machine. Run `ip a` to see it, not the Docker IP.

## VSCode with XDebug
Create a `.vscode/launch.json` with the following.
```
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Listen for XDebug",
            "type": "php",
            "request": "launch",
            "port": 9000,
            "log": false,
            "externalConsole": false,
            "pathMappings": {
                "/var/www/html": "${workspaceRoot}",
            },
            "ignore": ["**/vendor/**/*.php"]
        }
    ]
}
```

## PHPStorm with XDebug

1. Configure PHPStorm XDebug Configuration Settings
![PHPStorm XDebug Settings 1](wiki/xdebug-server-settings-2.png "PHPStorm XDebug Settings 2")

2. Configure PHPStorm DBGp Proxy Settings.  Make sure `IP Address` matches your local machine IP
![PHPStorm XDebug Settings 2](wiki/xdebug-server-settings-4.png "PHPStorm XDebug Settings 1")

3. Configure Project Path Mappings
![PHPStorm XDebug Settings 3](wiki/xdebug-server-settings-1.png "PHPStorm XDebug Settings 1")

4. Set a breakpoint in Phpstorm and you should be good to go

### Troubleshooting XDebug
`cat /etc/php/7.4/mods-available/xdebug.ini`

`cat /tmp/xdebug_remote.log`

`service php7.4-fpm reload`

### XDebug Resources
- https://serversforhackers.com/c/getting-xdebug-working
- https://www.jetbrains.com/help/phpstorm/troubleshooting-php-debugging.html
- https://www.jetbrains.com/help/phpstorm/configuring-xdebug.html
- https://www.jetbrains.com/help/phpstorm/creating-a-php-debug-server-configuration.html

## Connecting to a Docker Database Instance (Mysql/Postgres)

When connecting to the docker database you can use the settings provided in the `docker-compose.yml` file.

`localhost` and port `3306`, these will be mapped across to the docker images.

![Datagrip Server Settings 1](wiki/datagrip-server-settings-2.png "Datagrip Server Settings 1")

## If you need to use MySQL instead of Postgres, you can configure `docker-compose.yml` with the following:
```yml
  acme-database:
    image: mysql:latest
    hostname: acme-database
    container_name: acme-database
    command: --default-authentication-plugin=mysql_native_password
    networks:
      - acme
    ports:
      - 3306:3306
    volumes:
      - acme-db-data:/var/lib/mysql
    environment:
      - MYSQL_DATABASE=laravel
      - MYSQL_USER=laravel
      - MYSQL_PASSWORD=secret
      - MYSQL_ROOT_PASSWORD=root
```

## Redis
Configure redis as the default connection in `.env`.

`composer require predis/predis`

In `config/database.php` you might need to change:

`'client' => env('REDIS_CLIENT', 'redis'),`

to

`'client' => env('REDIS_CLIENT', 'predis'),`

```
QUEUE_CONNECTION=redis
```

Or for a specific job via:

```PHP
App\Jobs\ProcessJobExample::dispatch()->onConnection('redis');
```

Sample Redis Config
```
# Laravel Env Settings
# Configure Laravel to work with Docker containers.
# Use in laravel .env file

DB_CONNECTION=mysql
DB_HOST=docker-database
DB_PORT=3306
DB_DATABASE=laravel
DB_USERNAME=laravel
DB_PASSWORD=secret

REDIS_HOST=docker-redis
REDIS_PASSWORD=null
REDIS_PORT=6379

# To set Redis as default queue connection
QUEUE_CONNECTION=redis
```