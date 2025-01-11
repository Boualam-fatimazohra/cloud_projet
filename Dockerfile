# Base image
FROM php:8.2-apache

# Répertoire de travail
WORKDIR /var/www/html

# Configuration des sources
RUN touch /etc/apt/sources.list
RUN sed -i 's/deb.debian.org/archive.debian.org/g' /etc/apt/sources.list

# Installation des dépendances système
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

# Installation de Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --version=2.5.8

# Installation de Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
RUN apt-get install -y nodejs

# Copie des fichiers du projet
COPY . .

# Configuration des permissions
RUN chown -R www-data:www-data /var/www/html
RUN mkdir -p /var/www/html/public/build/assets && \
    chown -R www-data:www-data /var/www/html/public/build

# Configuration du cache npm
RUN mkdir -p /var/www/.npm && \
    chown -R www-data:www-data /var/www/.npm
ENV npm_config_cache=/var/www/.npm

# Installation des dépendances Composer
RUN composer install --no-dev --optimize-autoloader --ignore-platform-reqs

# Configuration des permissions storage et cache
RUN chmod -R 775 /var/www/html/storage
RUN chmod -R 775 /var/www/html/bootstrap/cache

# Création du lien symbolique storage APRÈS l'installation des dépendances
RUN php artisan storage:link

# Installation et build des assets Node.js
USER www-data
RUN npm install && npm run build
USER root

# Configuration d'Apache
RUN a2enmod rewrite
COPY .docker/apache.conf /etc/apache2/sites-available/000-default.conf
RUN a2ensite 000-default.conf

# Copie et configuration de l'entrypoint
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 80

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["apache2ctl", "-D", "FOREGROUND"]