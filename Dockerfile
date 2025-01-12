# -------------------------------
# Base image
# -------------------------------
FROM php:8.2-apache

# -------------------------------
# Définir le répertoire de travail
# -------------------------------
WORKDIR /var/www/html

# -------------------------------
# Configuration des sources (Debian Archive)
# -------------------------------
RUN touch /etc/apt/sources.list && \
    sed -i 's/deb.debian.org/archive.debian.org/g' /etc/apt/sources.list

# -------------------------------
# Installation des dépendances système
# -------------------------------
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
    && docker-php-ext-install zip mbstring exif pcntl bcmath gd pdo_pgsql pgsql\
    && docker-php-ext-install pdo_pgsql pgsql\
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# -------------------------------
# Installation de Composer (2.5.8)
# -------------------------------
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --version=2.5.8

# -------------------------------
# Installation de Node.js (16.x)
# -------------------------------
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs

# -------------------------------
# Copier les fichiers du projet
# -------------------------------
COPY . .

# -------------------------------
# Configuration des permissions (projet)
# -------------------------------
RUN chown -R www-data:www-data /var/www/html && \
    mkdir -p /var/www/html/public/build/assets && \
    chown -R www-data:www-data /var/www/html/public/build

# -------------------------------
# Configuration du cache npm
# -------------------------------
RUN mkdir -p /var/www/.npm && \
    chown -R www-data:www-data /var/www/.npm
ENV npm_config_cache=/var/www/.npm

# -------------------------------
# Installation des dépendances PHP avec Composer
# -------------------------------
RUN composer install --no-dev --optimize-autoloader --ignore-platform-reqs

# -------------------------------
# Configuration des permissions (storage et cache Laravel)
# -------------------------------
RUN chmod -R 775 /var/www/html/storage && \
    chmod -R 775 /var/www/html/bootstrap/cache

# -------------------------------
# Lien symbolique pour les fichiers storage
# -------------------------------
RUN php artisan storage:link

# -------------------------------
# Installation et build des assets Node.js
# -------------------------------
USER www-data
RUN npm install && npm run build
USER root

# -------------------------------
# Configuration Apache (mod_rewrite + virtual host)
# -------------------------------
RUN a2enmod rewrite
COPY .docker/apache.conf /etc/apache2/sites-available/000-default.conf
RUN a2ensite 000-default.conf

# -------------------------------
# Copie et configuration de l'entrypoint
# -------------------------------
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# -------------------------------
# Exposer le port 80 pour Apache
# -------------------------------
EXPOSE 80

# -------------------------------
# Définir l'entrypoint et la commande de démarrage
# -------------------------------
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["apache2ctl", "-D", "FOREGROUND"]