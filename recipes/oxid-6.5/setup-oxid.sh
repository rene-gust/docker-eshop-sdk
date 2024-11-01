#!/bin/bash

set -e

SCRIPT_PATH=$(dirname ${BASH_SOURCE[0]})

cd $SCRIPT_PATH/../../ || exit

composer create-project --no-dev oxid-esales/oxideshop-project oxideshop dev-b-6.5-ce

cd oxideshop

# Configure shop
cp source/config.inc.php.dist source/config.inc.php

perl -pi\
  -e 'print "SetEnvIf Authorization \"(.*)\" HTTP_AUTHORIZATION=\$1\n\n" if $. == 1'\
  source/.htaccess

perl -pi\
  -e 's#<dbHost>#mysql#g;'\
  -e 's#<dbUser>#root#g;'\
  -e 's#<dbName>#example#g;'\
  -e 's#<dbPwd>#root#g;'\
  -e 's#<dbPort>#3306#g;'\
  -e 's#<sShopURL>#https://oxideshop.local/#g;'\
  -e 's#<sShopDir>#/var/www/oxideshop/source/#g;'\
  -e 's#<sCompileDir>#/var/www/oxideshop/source/tmp/#g;'\
  source/config.inc.php

composer config github-protocols https

# Configure Tests dependencies
composer require codeception/module-rest ^1.4.2 --dev --no-update
composer require codeception/module-phpbrowser ^1.0.2 --dev --no-update

composer update

chmod 775 source/out/pictures
chmod 775 source/out/media
chmod 775 source/log
chmod 775 source/export
chmod 775 source/tmp

php bin/oe-console oe:module:apply-configuration

echo "Done!"
