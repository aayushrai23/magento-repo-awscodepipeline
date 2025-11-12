#!/bin/bash
set -e

echo ">>> Setting permissions..."
chown -R www-data:www-data /var/www/html/magento/
chmod -R 775 /var/www/html/magento/

echo ">>> Running Magento upgrade..."
sudo -u www-data php /var/www/html/magento/bin/magento setup:upgrade

echo ">>> Compiling DI..."
sudo -u www-data php /var/www/html/magento/bin/magento setup:di:compile

echo ">>> Deploying static content..."
sudo -u www-data php /var/www/html/magento/bin/magento setup:static-content:deploy -f

echo ">>> Flushing cache..."
sudo -u www-data php /var/www/html/magento/bin/magento cache:flush

echo ">>> Restarting services..."
systemctl restart nginx
systemctl restart php8.1-fpm || true

echo ">>> Deployment completed successfully."
