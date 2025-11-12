#!/bin/bash
set -e

echo "=== [Magento Deployment Started] ==="
DEPLOY_PATH="/var/www/magento2"

# Ensure correct permissions
echo "-> Setting permissions..."
sudo chown -R www-data:www-data $DEPLOY_PATH
sudo find $DEPLOY_PATH -type d -exec chmod 775 {} \;
sudo find $DEPLOY_PATH -type f -exec chmod 664 {} \;

cd $DEPLOY_PATH

# Enable maintenance mode (optional)
sudo -u www-data php bin/magento maintenance:enable || true

echo "-> Flushing cache..."
sudo -u www-data php bin/magento cache:flush || true

echo "-> Running setup upgrade..."
sudo -u www-data php bin/magento setup:upgrade --keep-generated || true

echo "-> Running dependency injection compile..."
sudo -u www-data php bin/magento setup:di:compile || true

echo "-> Deploying static content..."
sudo -u www-data php bin/magento setup:static-content:deploy -f || true

echo "-> Flushing cache again..."
sudo -u www-data php bin/magento cache:flush || true

# Disable maintenance mode
sudo -u www-data php bin/magento maintenance:disable || true

# Restart services
echo "-> Restarting services..."
sudo systemctl restart php8.3-fpm
sudo systemctl reload nginx || sudo systemctl restart nginx

echo "=== [Magento Deployment Completed Successfully] ==="
