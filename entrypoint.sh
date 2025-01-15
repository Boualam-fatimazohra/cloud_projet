#!/bin/bash
set -e  # Arrêter le script en cas d'erreur

# Créer le fichier .env s'il n'existe pas
if [ ! -f .env ]; then
    cp .env.example .env
fi

# Générer la clé d'application
php artisan key:generate --force

# Nettoyer et mettre en cache la configuration
php artisan config:clear
php artisan config:cache
php artisan route:clear
php artisan route:cache
php artisan view:clear
php artisan view:cache

# Exécuter les migrations
php artisan migrate --force

# Vérifier les fichiers dans /var/www/html/public
echo "Vérification des fichiers dans /var/www/html/public..."
ls -l /var/www/html/public

# Configurer Apache pour utiliser le port 8081
sudo sed -i 's/Listen 80/Listen 8081/g' /etc/apache2/ports.conf
sudo sed -i 's/<VirtualHost \*:80>/<VirtualHost \*:8081>/g' /etc/apache2/sites-available/000-default.conf

# Copier et activer la configuration Apache personnalisée
sudo cp /var/www/html/apache.conf /etc/apache2/sites-available/cloud-projet.conf
sudo a2ensite cloud-projet.conf
sudo a2dissite 000-default.conf

# Définir ServerName pour éviter les avertissements Apache
echo "ServerName cloud-projet-gku4.onrender.com" | sudo tee -a /etc/apache2/apache2.conf

# Ajuster les permissions des fichiers
sudo chown -R www-data:www-data /var/www/html
sudo chmod -R 755 /var/www/html

# Redémarrer Apache
echo "Redémarrage d'Apache..."
sudo apache2ctl restart

# Vérifier le statut d'Apache
if ! pgrep apache2 > /dev/null; then
    echo "Erreur : Apache n'a pas démarré correctement."
    exit 1
else
    echo "Apache est en cours d'exécution."
fi

# Démarrer Apache en mode foreground
exec apache2-foreground