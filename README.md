# Development base

Docker based local environment that can be combined with https://github.com/OXID-eSales/docker-eshop-sdk-recipes for OXID eShop development.

Php and Npm users are synced with the current user so we will have all the rights to modify and access the content generated by using container commands.

## What we have here

For the start:

* Apache 2.4 (based on original httpd:2.4-alpine container)
  * Some example SSL certificate added and HTTPS supported for https://localhost.local and https://oxideshop.local domains
* PHP 7.4 / 8.0 / 8.1 / 8.2 fpm (based on oxidesales/oxideshop-docker-php containers which use the official php:x.x-fpm containers as a base) with:
  * composer 2
  * xDebug 3 with remote debug and profiler preconfigured
  * error reporting enabled
* MySQL 5.7 with adminer (original mysql container used)
* Mailhog preconfigured to catch outgoing emails

Additionally, check services directory:
* Npm container preconfigured, so you can easily regenerate grunt/gulp/other builder assets for modules/themes easier (based on node:latest)
* Chrome based selenium service available, for running your selenium tests (based on selenium/standalone-chrome-debug)
* Elasticsearch (also kibana to manage it) containers preconfigured
* NGINX container preconfigured to be used with our NGINX module
* Sphinx container which allows you to regenerate and improve our documentations locally much easier

## Requirements

* Docker (https://docs.docker.com/get-docker/)
* Docker compose (https://docs.docker.com/compose/install/)
* ``127.0.0.1 localhost.local`` - in your ``/etc/hosts`` file

## Quick start

```
git clone https://github.com/OXID-eSales/docker-eshop-sdk.git myProjectName
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

## Longer start

This example shows more precise configuration which can be used for your project. It is real usage flow:

```
git clone https://github.com/OXID-eSales/docker-eshop-sdk.git myProjectName
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

### npm Install
Assuiming you are already inside node container. You should run below command to install project dependencies.
```
npm install
```

### Run Grunt

Assuming that the Grunt has been installed and that the project has already been configured with a package.json then you should follow below steps after entering node container.
 1. Change to the project's destination directory.
 2. Install project dependencies with `npm install`
 3. Run Grunt with command `npm run grunt`

### Further Troubleshooting
When running the `npm install` command to install your project’s dependencies, the install process may hang. At that time installation hangs without any output.
To resolve such issue run below-mentioned commands.
```
npm config rm proxy
npm config rm https-proxy
npm config set registry https://registry.npmjs.org/
npm install
```


## Using Sphinx Container for Documentation Generation

To generate documentation from documentation repositories locally, we have a preconfigured Sphinx container that can be utilized.

To get started, ensure you import our Sphinx container service file using the following command: `make addsphinxservice`. Here's an example of how to use it:

```
# Clone shop developer documentation to source directory
git clone https://github.com/OXID-eSales/developer_documentation source/docs

# Add Sphinx container
make docpath=./source/docs addsphinxservice
```

To regenerate the documentation, simply execute the command `make generate-docs`. After doing this, you'll find the generated documentation in the `source/docs/build directory`.


## Configurations

### Apache

Custom configuration file: ``containers/httpd/project.conf``.

### PHP

Select PHP version to be used in docker-compose php container configuration.
Custom configuration file for php settings: ``containers/php/custom.ini``.

### Remote debugging with PHPSTORM

* Configure the CLI Interpreter
* Create a Server configuration and set mapping as source:/var/www/

## Issues and questions

Feel free to make improvements for the SDK via Pull requests.

Also, if there are problems with using it, consider creating the Issue in the "Issues" section of this repository on github.
