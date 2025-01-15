# Base image
FROM php:8.2-apache

# Set working directory
WORKDIR /var/www/html

# Configure sources (Debian Archive)
RUN touch /etc/apt/sources.list && \
    sed -i 's/deb.debian.org/archive.debian.org/g' /etc/apt/sources.list

# Install system dependencies
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

# Install Composer (2.5.8)
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --version=2.5.8

# Install Node.js (16.x)
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs

# Set project permissions
RUN mkdir -p /var/www/html/public/build/assets && \
    chown -R www-data:www-data /var/www/html

# Configure npm cache
RUN mkdir -p /var/www/.npm && \
    chown -R www-data:www-data /var/www/.npm

# Copy project files
COPY . .

# Install Composer dependencies as non-root user
USER www-data
RUN composer install --no-dev --optimize-autoloader

# Copy entrypoint script
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]