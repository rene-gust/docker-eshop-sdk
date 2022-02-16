# Development base

Docker based local development environment. Php and Npm users are synced with the current user, 
so we will have all the rights to modify and access the content generated by using container commands.

## What we have here

For the start:

* Apache 2.4 (based on original httpd:2.4-alpine container)
* PHP 7.4 / 8.0 / 8.1 fpm (based on original php:x.x-fpm containers) with:
  * composer 2
  * xDebug 3 with remote debug and profiler preconfigured
  * error reporting enabled
* MySQL 5.7 with adminer (original mysql container used)
* Mailhog preconfigured to catch outgoing emails
* SPX preconfigured (PHP Simple Profiler - https://github.com/NoiseByNorthwest/php-spx)
* Npm container preconfigured (based on node:latest)
* Chrome based selenium service available, for running your selenium tests (based on selenium/standalone-chrome-debug)

## Requirements

* Docker (https://docs.docker.com/get-docker/)
* Docker compose (https://docs.docker.com/compose/install/)
* ``127.0.0.1 localhost.local`` - in your ``/etc/hosts`` file

## Quick start

```
git clone https://github.com/Sieg/development.git myProjectName
cd myProjectName

# get some information about whats possible
make help

# setup rights and basic configuration files
make setup

# run example script which prepares several example files for you to see this environment functionality
make example
```

Access the website through the http://localhost.local
* phpinfo shown on index page
* example with database connection
* example with email sending and catching it with mailhog
    * run the composer install on php container first.

Adminer is available via http://localhost.local:8080
* Server: mysql
* Credentials: root/root

Mailhog is available via http://localhost.local:8025/

SPX preconfigured and UI accessible via http://localhost.local?SPX_KEY=dev&SPX_UI_URI=/

## Longer start

This example shows more precise configuration which can be used for your project. It is real usage flow:

```
git clone https://github.com/Sieg/development.git myProjectName
cd myProjectName

# setup rights and basic configuration files
make setup

# add php, mysql and apache services (they are grouped in one command, but can be added separately if needed)
make addbasicservices

# add selenium container to the docker-compose
make file=services/selenium-chrome.yml addservice

# ensure you have source directory available, as its configured as webroot by default
mkdir source

# start everything
make up

# stop everything when its enough :)
make down
```

## Running php stuff

We can connect to the php container and do the stuff in there:
```
make php
php -v
```

Note: ``make php`` is just an alias for ``docker-compose exec php bash``

We can call commands directly without connecting to the container:
```
docker-compose run php php -v
```

## Running npm commands

### Direct call
```
docker-compose run node npm install bootstrap
```

### Connect to node container
```
make node
```

## Configurations

### Apache

Custom configuration file: ``containers/httpd/project.conf``.

### PHP

Select PHP version to be used in docker-compose php container configuration.
Custom configuration file for php settings: ``containers/php-fpm/custom.ini``.

### Remote debugging with PHPSTORM

* Configure the CLI Interpreter
* Create a Server configuration and set mapping as source:/var/www/
