FROM php:8.1-fpm

RUN apt update
RUN apt-get install -y libzip-dev zip unzip \
    libpng-dev libonig-dev \
    libxml2-dev docker.io \
    libjpeg-dev ghostscript \
    libmagickwand-dev

RUN docker-php-ext-configure gd --enable-gd --with-jpeg

RUN docker-php-ext-install zip
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install gd
RUN docker-php-ext-install mbstring
RUN docker-php-ext-install xml
RUN docker-php-ext-install exif

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copy existing application directory contents
WORKDIR /var/www/html
RUN chown -R www-data:www-data /var/www/html
COPY --chown=www-data:www-data . .
RUN chmod -R 777 /var/www/html/storage

# Change current user to www
USER www-data
RUN composer install

EXPOSE 9000
CMD ["php-fpm"]
