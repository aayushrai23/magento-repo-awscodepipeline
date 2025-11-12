#!/bin/bash
set -e

echo "=== [Magento Cleanup Started] ==="
DEPLOY_PATH="/var/www/magento2"

# Stop web service before cleanup
sudo systemctl stop nginx || true
sudo systemctl stop php8.3-fpm || true

# Clean caches and generated files
echo "-> Cleaning Magento caches and generated code..."
rm -rf $DEPLOY_PATH/var/cache/*
rm -rf $DEPLOY_PATH/var/page_cache/*
rm -rf $DEPLOY_PATH/var/log/*
rm -rf $DEPLOY_PATH/generated/*
rm -rf $DEPLOY_PATH/pub/static/*

# Restart services
echo "-> Restarting services after cleanup..."
sudo systemctl start php8.3-fpm
sudo systemctl start nginx

echo "=== [Magento Cleanup Completed] ==="
