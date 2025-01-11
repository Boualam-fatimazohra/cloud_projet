# Utiliser une image PHP officielle avec Apache
FROM php:8.2-apache

# Définir le répertoire de travail
WORKDIR /var/www/html

# Créer le fichier sources.list s'il n'existe pas
RUN touch /etc/apt/sources.list

# Utiliser un miroir de secours pour APT
RUN sed -i 's/deb.debian.org/archive.debian.org/g' /etc/apt/sources.list

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
    && docker-php-ext-install zip pdo_mysql mbstring exif pcntl bcmath gd pdo_pgsql pgsql \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Installer Composer (avec une version spécifique)
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --version=2.5.8

# Installer Node.js et npm
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
RUN apt-get install -y nodejs

# Copier les fichiers du projet dans le conteneur
COPY . .

# Définir les permissions pour le répertoire /var/www/html
RUN chown -R www-data:www-data /var/www/html

# Définir les permissions pour le dossier public/build
RUN mkdir -p /var/www/html/public/build/assets && \
    chown -R www-data:www-data /var/www/html/public/build

# Définir les permissions pour le cache npm
RUN mkdir -p /var/www/.npm && \
    chown -R www-data:www-data /var/www/.npm

# Définir un dossier de cache npm accessible
ENV npm_config_cache=/var/www/.npm

# Installer les dépendances Node.js et compiler les assets
USER www-data
RUN npm install && npm run build
USER root

# Copier et rendre exécutable le script entrypoint.sh
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Définir les permissions pour le dossier de stockage
RUN chown -R www-data:www-data /var/www/html/storage

# Installer les dépendances PHP
RUN composer install --no-dev --optimize-autoloader --ignore-platform-reqs

# Configurer Apache pour Laravel
RUN a2enmod rewrite
COPY .docker/apache.conf /etc/apache2/sites-available/000-default.conf

# Exposer le port 80
 EXPOSE 80

# Utiliser le script entrypoint.sh comme point d'entrée
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
COPY .docker/apache.conf /etc/apache2/sites-available/000-default.conf