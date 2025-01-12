#!/bin/bash

# Attendre que la base de données soit prête (si nécessaire)
# while ! nc -z $DB_HOST $DB_PORT; do
#     sleep 1
# done

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

# Vérifier les permissions
chown -R www-data:www-data /var/www/html/storage
chmod -R 775 /var/www/html/storage
chown -R www-data:www-data /var/www/html/bootstrap/cache
chmod -R 775 /var/www/html/bootstrap/cache

# Migrations (avec --force pour l'environnement de production)
php artisan migrate --force
php artisan migrate:status
# Vérifier si Apache est déjà en cours d'exécution
if ! pgrep apache2; then
    echo "Redémarrage d'Apache..."
    service apache2 restart
else
    echo "Apache est déjà en cours d'exécution."
fi
tail -f /var/log/apache2/error.log
# Démarrage d'Apache en mode foreground
exec apache2-foreground