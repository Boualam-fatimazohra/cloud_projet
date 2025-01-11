#!/bin/bash

# Set permissions
chown -R www-data:www-data /var/www/html/storage
chown -R www-data:www-data /var/www/html/bootstrap/cache

# Run migrations and seeders
php artisan migrate --force
php artisan db:seed --force

# Start Apache
exec apache2-foreground