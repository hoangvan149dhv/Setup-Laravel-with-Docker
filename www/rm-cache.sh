#!/usr/bin/env bash

php artisan key:generate
php artisan cache:clear
php artisan view:clear
php artisan config:clear
php artisan route:clear
php artisan queue:restart
