#!/bin/bash
set -e

echo ">>> Cleaning old Magento cache and generated files..."

# Clear var and generated directories without deleting required structure
rm -rf /var/www/html/magento/var/cache/*
rm -rf /var/www/html/magento/var/page_cache/*
rm -rf /var/www/html/magento/var/view_preprocessed/*
rm -rf /var/www/html/magento/generated/code/*
rm -rf /var/www/html/magento/generated/metadata/*

# Ensure Magento required directories exist
mkdir -p /var/www/html/magento/var/cache
mkdir -p /var/www/html/magento/generated/code
mkdir -p /var/www/html/magento/generated/metadata

echo ">>> Cleanup completed successfully."
