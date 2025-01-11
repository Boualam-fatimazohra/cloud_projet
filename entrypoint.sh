#!/bin/sh
set -e  # Arrêter le script en cas d'erreur

# Exécuter les migrations
php artisan migrate --force

# Exécuter les seeders
php artisan db:seed --force

# Démarrer Apache
exec apache2-foreground