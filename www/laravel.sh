#!/usr/bin/env bash

# Create env
cp ./.env.example ./.env

# composer install
composer install

# Generate key
php artisan key:generate
# Remove cache
php artisan cache:clear
php artisan view:clear
php artisan config:clear
php artisan route:clear
php artisan queue:restart

# Run php-fpm
php-fpm