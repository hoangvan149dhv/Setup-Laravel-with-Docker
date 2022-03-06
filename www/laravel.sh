#!/usr/bin/env bash

composer create-project --prefer-dist laravel/laravel laravel "5.8.*"

# Create env
cp ./.env.example ./.env

# composer install
cd laravel

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