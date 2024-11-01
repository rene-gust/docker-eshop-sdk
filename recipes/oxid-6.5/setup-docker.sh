#!/bin/bash

set -e

SCRIPT_PATH=$(dirname ${BASH_SOURCE[0]})

cd $SCRIPT_PATH/../../ || exit

cp containers/php/xdebug.ini.dist containers/php/xdebug.ini
cp containers/php/custom.ini.dist containers/php/custom.ini

# Prepare services configuration
make setup
make addbasicservices
make file=services/adminer.yml addservice

# Configure containers
perl -pi\
  -e 's#/var/www/#/var/www/oxideshop/source/#g;'\
  containers/httpd/project.conf

perl -pi\
  -e 'print "SetEnvIf Authorization \"(.*)\" HTTP_AUTHORIZATION=\$1\n\n" if $. == 1'\
  oxideshop/source/.htaccess

# Start all containers
make build

echo "Done!"
