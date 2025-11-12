#!/bin/bash
set -e

echo ">>> Stopping nginx"
systemctl stop nginx || true

echo ">>> Cleaning old Magento cache"
rm -rf /var/www/html/magento/var/cache/*
rm -rf /var/www/html/magento/var/log/*
rm -rf /var/www/html/magento/generated/*

echo ">>> Cleanup done"
