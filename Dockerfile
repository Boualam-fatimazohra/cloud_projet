# Utiliser l'image de base PHP 8.2 avec Apache
FROM php:8.2-apache

# Définir le répertoire de travail
WORKDIR /var/www/html

# Installer les dépendances système
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
    && docker-php-ext-install zip mbstring exif pcntl bcmath gd pdo_pgsql pgsql \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Installer Composer (version 2.5.8)
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --version=2.5.8

# Installer Node.js (version 16.x)
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs

# Configurer les permissions pour le répertoire du projet
RUN mkdir -p /var/www/html/public/build/assets && \
    mkdir -p /var/www/html/vendor && \
    chown -R www-data:www-data /var/www/html

# Configurer le cache npm
RUN mkdir -p /var/www/.npm && \
    chown -R www-data:www-data /var/www/.npm

# Copier les fichiers du projet
COPY --chown=www-data:www-data . .

# Installer les dépendances Composer en tant qu'utilisateur non-root
USER www-data
RUN composer install --no-dev --optimize-autoloader

# Copier le script entrypoint
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Définir l'entrée du conteneur
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]