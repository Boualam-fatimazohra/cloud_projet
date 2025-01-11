# Utiliser une image PHP officielle avec Apache
FROM php:8.2-apache

# Définir le répertoire de travail
WORKDIR /var/www/html

# Créer le fichier sources.list s'il n'existe pas
RUN touch /etc/apt/sources.list

# Utiliser un miroir de secours pour APT
RUN sed -i 's/deb.debian.org/archive.debian.org/g' /etc/apt/sources.list

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
# Installer les dépendances système nécessaires pour Laravel et PostgreSQL

RUN apt-get update && apt-get install -y \
    libzip-dev \
    zip \
    unzip \
    git \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libonig-dev \
    libpq-dev \ 
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install zip pdo_mysql mbstring exif pcntl bcmath gd \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Installer Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copier les fichiers du projet dans le conteneur
COPY . .

# Définir les permissions pour le dossier de stockage
RUN chown -R www-data:www-data /var/www/html/storage

# Installer les dépendances PHP
RUN composer install --no-dev --optimize-autoloader --ignore-platform-reqs

# Configurer Apache pour Laravel
RUN a2enmod rewrite
COPY .docker/apache.conf /etc/apache2/sites-available/000-default.conf

# Exposer le port 80
EXPOSE 80

# Commande pour démarrer Apache
CMD ["apache2-foreground"]