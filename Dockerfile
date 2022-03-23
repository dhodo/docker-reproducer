FROM php:7.4-apache

# PHP
RUN apt-get update && apt-get install -y --no-install-recommends \
        curl \
        libc-client-dev \
        libkrb5-dev \
        libbz2-dev \
        libgmp-dev \
        libsodium23 \
        libsodium-dev \
        libpng-dev \
        libpq-dev \
        libxslt1-dev \
        libzip-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd

RUN docker-php-ext-install bz2 \
    && docker-php-ext-install exif \
    && docker-php-ext-install iconv \
    && docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
    && docker-php-ext-install imap \
    && docker-php-ext-install intl\
    && docker-php-ext-install mysqli \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install sodium \
    && docker-php-ext-install xsl \
    && docker-php-ext-install zip \
    && rm -r /var/lib/apt/lists/*

# Install xdebug
RUN pecl install xdebug && docker-php-ext-enable xdebug

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install NodeJS & Yarn
RUN curl -sL https://deb.nodesource.com/setup_15.x | bash -
RUN apt-get -y install nodejs
RUN npm install -g yarn

