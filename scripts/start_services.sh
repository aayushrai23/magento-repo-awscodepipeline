#!/bin/bash
set -e

echo "=== Starting Magento Services ==="
systemctl restart nginx
systemctl restart php8.1-fpm || systemctl restart php7.4-fpm || true

echo "=== Magento Deployment Completed Successfully ==="
