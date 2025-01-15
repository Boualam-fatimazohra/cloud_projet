#!/bin/bash
set -e  # Arrêter le script en cas d'erreur

# Création du fichier .env si nécessaire
if [ ! -f .env ]; then
    cp .env.example .env
fi

# Génération de la clé d'application
php artisan key:generate --force

# Cache de la configuration
php artisan config:clear
php artisan config:cache
php artisan route:clear
php artisan route:cache
php artisan view:clear
php artisan view:cache

# Vérifier la configuration
php artisan config:clear
php artisan route:clear
php artisan cache:clear

# Migrations (avec --force pour l'environnement de production)
php artisan migrate --force

# Vérification des fichiers dans /var/www/html/public
echo "Vérification des fichiers dans /var/www/html/public..."
ls -l /var/www/html/public

# Installer les dépendances Composer
composer install --no-dev --optimize-autoloader

# Configuration des permissions
chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html
chmod -R 775 /var/www/html/storage
chmod -R 775 /var/www/html/bootstrap/cache

# Configuration d'Apache pour utiliser le port 8080
sed -i 's/Listen 80/Listen 8080/g' /etc/apache2/ports.conf
sed -i 's/<VirtualHost \*:80>/<VirtualHost \*:8080>/g' /etc/apache2/sites-available/000-default.conf

# Redémarrage d'Apache
echo "Redémarrage d'Apache..."
apache2ctl restart

# Démarrage d'Apache en mode foreground
exec apache2-foreground