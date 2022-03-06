#!/usr/bin/env bash

# composer install
composer install

# Remove cache
php artisan cache:clear
php artisan view:clear
php artisan config:clear
php artisan route:clear
php artisan queue:restart

# Run php-fpm
php-fpm