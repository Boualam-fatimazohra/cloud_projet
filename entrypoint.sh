#!/bin/bash
set -e  # Stop the script on error

# Create .env file if it doesn't exist
if [ ! -f .env ]; then
    cp .env.example .env
fi

# Generate application key
php artisan key:generate --force

# Clear and cache configuration
php artisan config:clear
php artisan config:cache
php artisan route:clear
php artisan route:cache
php artisan view:clear
php artisan view:cache

# Clear caches
php artisan config:clear
php artisan route:clear
php artisan cache:clear

# Run migrations
php artisan migrate --force

# Check files in /var/www/html/public
echo "Checking files in /var/www/html/public..."
ls -l /var/www/html/public

# Install Composer dependencies as non-root user
sudo -u www-data composer install --no-dev --optimize-autoloader

# Set permissions
chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html
chmod -R 775 /var/www/html/storage
chmod -R 775 /var/www/html/bootstrap/cache

# Configure Apache to use port 8081
sed -i 's/Listen 80/Listen 8081/g' /etc/apache2/ports.conf
sed -i 's/<VirtualHost \*:80>/<VirtualHost \*:8081>/g' /etc/apache2/sites-available/000-default.conf

# Set ServerName to avoid Apache warning
echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Restart Apache
echo "Restarting Apache..."
apache2ctl restart

# Check Apache status
if ! pgrep apache2 > /dev/null; then
    echo "Error: Apache did not start correctly."
    exit 1
else
    echo "Apache is running."
fi

# Start Apache in foreground mode
exec apache2-foreground