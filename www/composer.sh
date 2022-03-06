#! /bin/bash
php-fpm
# composer install
composer install
php artisan cache:clear
php artisan view:clear
php artisan config:clear
php artisan route:cache
php artisan queue:restart