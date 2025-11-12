#!/bin/bash
set -e
echo "=== [Magento Cleanup Started] ==="
sudo systemctl stop nginx || true

echo "-> Cleaning Magento caches and generated code..."
sudo rm -rf /var/www/magento2/var/cache/* || true
sudo rm -rf /var/www/magento2/var/page_cache/* || true
sudo rm -rf /var/www/magento2/generated/* || true
sudo rm -rf /var/www/magento2/var/log/* || true

echo "-> Restarting Nginx..."
sudo systemctl start nginx
echo "=== [Magento Cleanup Completed] ==="
