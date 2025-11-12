#!/bin/bash
set -e
echo "=== [Magento Deployment Started] ==="

cd /var/www/magento2

echo "-> Setting permissions..."
sudo chown -R www-data:www-data /var/www/magento2
sudo chmod -R 775 /var/www/magento2

echo "-> Running Magento setup..."
sudo -u www-data php bin/magento setup:upgrade
sudo -u www-data php bin/magento setup:di:compile
sudo -u www-data php bin/magento setup:static-content:deploy -f

echo "-> Flushing cache..."
sudo -u www-data php bin/magento cache:flush

echo "-> Restarting Nginx..."
sudo systemctl restart nginx

echo "=== [Magento Deployment Completed Successfully] ==="
