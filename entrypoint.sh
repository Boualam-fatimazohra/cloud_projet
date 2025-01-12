#!/bin/bash

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

# Vérifier si Apache est déjà en cours d'exécution
if ! pgrep apache2; then
    echo "Redémarrage d'Apache..."
    service apache2 restart
else
    echo "Apache est déjà en cours d'exécution."
fi

# Démarrage d'Apache en mode foreground
exec apache2-foreground