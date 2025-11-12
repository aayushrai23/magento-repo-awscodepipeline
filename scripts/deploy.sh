#!/bin/bash

cd /var/www/html/magento || exit 1

echo ">>> Setting ownership and permissions..."
chown -R www-data:www-data /var/www/html/magento
chmod -R 775 var pub generated

echo ">>> Configuring Magento to use MySQL search engine (temporary workaround)..."
php bin/magento config:set catalog/search/engine mysql || true

echo ">>> Running Magento upgrade..."
php bin/magento setup:upgrade

echo ">>> Generating static content..."
php bin/magento setup:static-content:deploy -f

echo ">>> Setting permissions again..."
chmod -R 775 var pub generated

echo ">>> Cleaning cache..."
php bin/magento cache:flush

echo ">>> Deployment completed successfully!"
