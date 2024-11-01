#!/bin/bash

set -e

SCRIPT_PATH=$(dirname ${BASH_SOURCE[0]})

cd $SCRIPT_PATH/../../ || exit

mkdir -p ./oxideshop/var/configuration/environment
cp $SCRIPT_PATH/environment/1.yaml ./oxideshop/var/configuration/environment/1.yaml

cd oxideshop

#git clone https://github.com/OXID-eSales/paypal-module source/modules/osc/paypal-module

composer config repositories.oxid-esales/paypal-module \
  --json '{"type":"path", "url":"./source/modules/osc/paypal-module", "options": {"symlink": true}}'
composer require oxid-solution-catalysts/paypal-module:dev-b-6.3.x --no-update

composer update oxid-solution-catalysts/paypal-module

vendor/bin/oe-console oe:module:install-configuration source/modules/osc/paypal-module

php vendor/bin/oe-console oe:module:apply-configuration

php vendor/bin/oe-console oe:module:activate oepaypal

echo "Done!"
